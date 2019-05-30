import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_up/GoogleSignInButton/GoogleSignInButton.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';
import 'Requests.dart';

class AppUser
{
	String id = "NONE";
	String name = "";
	String email = "";
	String username = "";

	int schoolId;

	set_if_not_null(var variable, var value)
	{
		if(value != null)
			return value;
		return variable;
	}

	AppUser(var json)
	{
		this.id = set_if_not_null(this.id, json['id']);
		this.name = set_if_not_null(this.name, json['name']);
		this.username = set_if_not_null(this.username, json['username']);
		this.email = set_if_not_null(this.email, json['email']);
	}
}

class UserManager
{
	static AppUser user;

	static bool logged_in() => user != null;
}

class LoginManager extends StatefulWidget
{
	@override
	LoginManagerState createState() => LoginManagerState();
}

class LoginManagerState extends State<LoginManager>
{
	GoogleSignInButton loginButton;
	GoogleSignIn googleSignIn;

	LoginManagerState()
	{
		loginButton = login_button();
		googleSignIn = new GoogleSignIn(scopes: ['email']);

		initLogin();

		if(UserManager.user == null)
			googleSignIn.signInSilently();
	}

	login_button() => GoogleSignInButton(onPressed: logIn);
	logout_button() => GoogleSignInButton(text: "Sign out", onPressed: logOut);

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

		return Requests.post(data, serverUrl + "users/signin", emptyResponse: "Not logged in", errorInfo: "Failed to sign in to Server.");
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