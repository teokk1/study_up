import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:study_up/Duels/DuelChooseOpponentScreen.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/MainScreen/AppLogo.dart';
import 'package:study_up/MainScreen/MainAppDrawer.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import 'Duels/DuelDialog.dart';
import 'Globals.dart';
import 'HTTP/Requests.dart';
import 'QA/QASetup.dart';

void main() => runApp(App());

class App extends StatelessWidget
{
	static final snackBarScaffoldKey = GlobalKey<ScaffoldState>();
	
	@override
	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			debugShowCheckedModeBanner: false,
			title: 'Flutter Demo',
			color: backgroundColor,
			home: HomePage(title: 'StudyUp!'),
			theme: ThemeData
			(
				primarySwatch: Colors.lightGreen,
				backgroundColor: backgroundColor,
				primaryColor: primaryColor,
				accentColor: darkerAccentColor,

				brightness: Brightness.dark,

//				fontFamily: 'Montserrat',

//				textTheme: TextTheme
//				(
//					headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//					title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//					body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
//				),
			),
			builder: (context, child)
			{
				return Scaffold
				(
					key: snackBarScaffoldKey,
					body: child
				);
			},
		);
	}
}

class HomePage extends StatefulWidget
{
	final String title;

	HomePage({Key key, this.title}) : super(key: key);

	@override
	HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
{
	FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
	LoginManager loginManager;

	HomePageState()
	{
		firebaseMessaging.requestNotificationPermissions();
		firebaseMessaging.configure(onMessage: on_message, onResume: on_resume, onLaunch: on_launch);
		
		loginManager = LoginManager(firebaseMessaging);
	}
	
	void handle_message(Map<String, dynamic> message)
	{
		if(message['data']['sender'] == null)
			basic_dialog(context, message['title'], message['body'], (){}, (){}, yesString: "Ok", noString: "");
		else
			DuelDialog.show_dialog(context,  DuelInfo(message));
	}
	
	Future<dynamic> on_message(Map<String, dynamic> message) async
	{
		handle_message(message);
	}
	
	Future<void> on_resume(Map<String, dynamic> message) async
	{
		handle_message(message);
	}
	
	Future<void> on_launch(Map<String, dynamic> message) async
	{
		handle_message(message);
	}
	
	duel_screen()
	{
		navigate_to(context, DuelChooseOpponentScreen());
	}
	
	training_setup_screen()
	{
		var title = "Odaberi pitanja iz";
		var groupEndPoint = "users/${UserManager.user.id}/groups";
		var fetchFunction = (groupId) => Requests.random_questions(groupId, 10);
		var whenDone = (int points, int totalQuestions) => {};
		
		QASetupScreen.qa_prep_navigate(context, title, groupEndPoint, fetchFunction, whenDone);
	}

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold
		(
			create_menu
			(
				[
					Expanded(flex: 5, child: AppLogo()),
					Expanded
					(
						flex: 12,
						child: Column
						(
							children:
							[
								create_button("Dvoboj", duel_screen),
								spacing(10.0),
								create_button("Trening", training_setup_screen),
							],
							mainAxisAlignment: MainAxisAlignment.start,
						),
					),
					loginManager,
					spacing(20.0),
				],
				mainAxisAlignment: MainAxisAlignment.center
			),
			appBar: basic_app_bar(),
			drawer: MainAppDrawer.create(context),
//			bottomNavigationBar: BottomAppBar
//			(
//				child: Padding
//				(
//					padding: EdgeInsets.all(8.0),
//					child: Row
//					(
//						mainAxisAlignment: MainAxisAlignment.center,
//						children: [loginManager]
//					),
//				),
//				color: backgroundColor,
//				elevation: 0.0,
//			),
			decoration: main_gradient_decoration(),
		);
	}
}