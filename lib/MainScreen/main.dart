import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/Training/TrainingSetup.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../DuelScreen.dart';
import '../Globals.dart';
import 'AppLogo.dart';
import 'MainAppDrawer.dart';

void main() => runApp(App());

class App extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			debugShowCheckedModeBanner: false,
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
	HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
{
	LoginManager loginManager;

	HomePageState()
	{
		loginManager = LoginManager();
	}

	duel_screen() => navigate_to(context, DuelScreen());
	training_setup_screen() => navigate_to(context, TrainingSetupScreen());

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold
		(
			create_menu
			([
				AppLogo(),

				create_button("Dvoboj", duel_screen),
				create_button("Trening", training_setup_screen),
				spacing(20.0),
				loginManager,
			]),
			appBar: basic_app_bar(),
			drawer: MainAppDrawer.create(context),
		);
	}
}