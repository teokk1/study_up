import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class AppUser
{
	String id;
	String name;
	String email;

	AppUser(var json)
	{
		this.id = json['id'];
		this.name = json['name'];
		this.email = json['email'];
	}
}

class UserManager
{
	static AppUser user;
}

class LoginManager extends StatefulWidget
{
	@override
	LoginManagerState createState() => LoginManagerState();
}

class LoginManagerState extends State<LoginManager>
{
	RaisedButton loginButton;
	GoogleSignIn googleSignIn;

	LoginManagerState()
	{
		loginButton = login_button();
		googleSignIn = new GoogleSignIn(scopes: ['email']);

		initLogin();

		if(UserManager.user == null)
			googleSignIn.signInSilently();
	}

	login_button() => RaisedButton(onPressed: () => logIn(), child: Text("Login with Google"), color: accentColor);
	logout_button() => RaisedButton(onPressed: () => logOut(), child: Text("Logout"), color: accentColor);

	initLogin()
	{
		googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async
		{
			if (account != null)
			{
				loggedIn(account.email);
			}
			else
			{
				// user NOT logged
			}
		});
	}

	Future<Map<String, dynamic>> signin_to_server(var email) async
	{
		Map data =
		{
			"email": email
		};

		var body = json.encode(data);

		var response = await http.post(serverUrl + "users/signin", headers: {"Content-Type": "application/json"}, body: body);

		if (response.statusCode == 200)
			return jsonDecode(response.body);
		else
			throw Exception('Failed to sign in to server. Error code: ' + response.statusCode.toString() + " " + response.body + body.toString());
	}

	loggedIn(var email) async
	{
		UserManager.user = AppUser(await signin_to_server(email));
		setState(() => this.loginButton = logout_button());

		create_snackbar(context, "Logged in as $email");
	}

	logIn() async
	{
//		showLoading();
		await googleSignIn.signIn();
	}

	logOut()
	{
		UserManager.user = null;
		googleSignIn.signOut();
		setState(() => this.loginButton = login_button());
		create_snackbar(context, "Logged out.");
	}

	@override
	Widget build(BuildContext context)
	{
		return Container(child: loginButton);
	}
}