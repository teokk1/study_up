import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_up/GoogleSignInButton/GoogleSignInButton.dart';
import 'package:study_up/SignalR/SignalRTest.dart';
import 'package:study_up/Tests/TestsScreen.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';
import 'Requests.dart';

class AppUser
{
	String id = "NONE";
	String name = "";
	String email = "";
	String username = "";
	
	String token;

	int schoolId;
	
	SignalR signalRClient;

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
		this.username = set_if_not_null(this.username, json['userName']);
		this.email = set_if_not_null(this.email, json['email']);
		
		signalRClient = SignalR(this.id);
	}
}

class UserManager
{
	static AppUser user;
	static bool logged_in() => user != null;
	
	static int duelHack = -1;
	
	static void update_context(BuildContext context)
	{
		user.signalRClient.context = context;
	}
}

class LoginManager extends StatefulWidget
{
	FirebaseMessaging firebaseMessaging;
	LoginManager(this.firebaseMessaging);
	
	@override
	LoginManagerState createState() => LoginManagerState(firebaseMessaging);
}

class LoginManagerState extends State<LoginManager>
{
	FirebaseMessaging firebaseMessaging;
	
	GoogleSignInButton loginButton;
	GoogleSignIn googleSignIn;

	LoginManagerState(this.firebaseMessaging)
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
				loggedIn(account.email);
		});
	}

	Future<Map<String, dynamic>> signin_to_server(var email) async
	{
		var token = await firebaseMessaging.getToken();
		
		Map data =
		{
			"email": email,
			"firebaseToken" : token
		};

		return Requests.post(data, serverUrl + "users/signin", emptyResponse: "Not logged in", errorInfo: "Failed to sign in to Server.");
	}

	loggedIn(var email) async
	{
		UserManager.user = AppUser(await signin_to_server(email));
		UserManager.update_context(context);
		
		setState(() => this.loginButton = logout_button());

		create_snackbar(context, "Logged in as $email");
		check_for_tests();
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

	check_for_tests() async
	{
		var tests = await Requests.get_list(serverUrl + "users/" + UserManager.user.id + "/tests");

		print(tests);
		if(tests.length > 0)
		{
			create_snackbar(context, "Imate nove testove!", duration: 5000, actionLabel: "Idi", action: go_to_tests);
		}
	}

	go_to_tests()
	{
		navigate_to(context, TakeTestsScreen());
	}
}