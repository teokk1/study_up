import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_up/Manage/manage_screen.dart';

import 'Globals.dart';
import 'duel_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			title: 'Flutter Demo',
			theme: ThemeData(primarySwatch: Colors.lightGreen, backgroundColor: backgroundColor),
			color: backgroundColor,
			home: HomePage(title: 'StudyUp!'),
		);
	}
}

class HomePage extends StatefulWidget
{
	final String title;

	HomePage({Key key, this.title}) : super(key: key);

	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
	duel_screen() => navigate_to(context, DuelScreen());
	manage_screen() => navigate_to(context, ManageScreen());

	GoogleSignIn googleSignIn = new GoogleSignIn
	(
		scopes:
		[
			'email',
			'https://www.googleapis.com/auth/contacts.readonly',
		],
	);

	initLogin()
	{
		googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async
		{
			if (account != null)
			{
				// user logged
			}
			else
			{
				// user NOT logged
			}
		});
//		_googleSignIn.signInSilently().whenComplete(() => dismissLoading());
	}

	doLogin() async
	{
//		showLoading();
		await googleSignIn.signIn();
	}

	create_logo()
	{
		return Padding
		(
			padding: EdgeInsets.all(10.0),
			child: Image.asset('assets/images/logo.png'),
		);
	}

	create_menu(List<Widget> children)
	{
		return Align
		(
			alignment: Alignment.topCenter,
			child: Column
			(
				//mainAxisAlignment: MainAxisAlignment.center,
				children: children,
			),
		);
	}

	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			backgroundColor: backgroundColor,
			body: Padding
			(
			  padding: mainPadding,
			  child: create_menu
			  ([
				  create_logo(),

				  create_button("Duel", duel_screen),
				  create_button("Manage", manage_screen),

				  RaisedButton(onPressed: () => doLogin(), child: Text("Login with Google"), color: accentColor),
			  ]),
			),
		);
	}
}