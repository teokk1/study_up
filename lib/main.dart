import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Globals.dart';
import 'duel_screen.dart';
import 'manage_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			title: 'Flutter Demo',
			theme: ThemeData(primarySwatch: Colors.lightGreen, backgroundColor: Colors.lightGreen),
			color: Colors.lightGreen,
			home: HomePage(title: 'StudyUp!'),
		);
	}
}

class HomePage extends StatefulWidget
{
	HomePage({Key key, this.title}) : super(key: key);

	final String title;

	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
	RoundedRectangleBorder rounded_button_rect()
	{
		return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0));
	}

	duel_screen()
	{
		Navigator.push(context, MaterialPageRoute(builder: (context) => DuelScreen()),);
	}

	manage_screen()
	{
		Navigator.push(context, MaterialPageRoute(builder: (context) => ManageScreen()),);
	}

	GoogleSignIn _googleSignIn = new GoogleSignIn(
		scopes: [
			'email',
			'https://www.googleapis.com/auth/contacts.readonly',
		],
	);

	initLogin()
	{
		_googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
			if (account != null) {
				// user logged
			} else {
				// user NOT logged
			}
		});
//		_googleSignIn.signInSilently().whenComplete(() => dismissLoading());
	}

	doLogin() async {
//		showLoading();
		await _googleSignIn.signIn();
	}

	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			backgroundColor: Colors.amber,
			body: Padding
			(
			  padding: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0),
			  child: Align
			  (
			  	alignment: Alignment.topCenter,
			  	child: Column
			  	(
			  		//mainAxisAlignment: MainAxisAlignment.center,
			  		children: <Widget>
			  		[
			  			Image.asset('assets/images/logo.png'),
			  			RaisedButton(child: Text("Duel"), color: buttonColor, shape: rounded_button_rect(), onPressed: duel_screen),
						RaisedButton(child: Text("Manage"), color: buttonColor, shape: rounded_button_rect(), onPressed: manage_screen),

				  		RaisedButton(onPressed: () => doLogin(), child: Text("Login G+"), color: Colors.primaries[0]),
			  		],
			  	),
			  ),
			),
		);
	}
}