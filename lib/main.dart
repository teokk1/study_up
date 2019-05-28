import 'package:flutter/material.dart';

import 'DuelScreen.dart';
import 'Globals.dart';
import 'Groups/GroupsScreen.dart';
import 'HTTP/Auth.dart';
import 'Training/TrainingSetup.dart';
import 'WidgetHelpers/WidgetHelpers.dart';

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
	groups_screen() => navigate_to(context, GroupsScreen());
	training_setup_screen() => navigate_to(context, TrainingSetupScreen());

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold
		(
			create_menu
			([
				AppLogo(),

				create_button("Duel", duel_screen),
				create_button("Groups", groups_screen),
				create_button("Train", training_setup_screen),

				loginManager,
			])
		);
	}
}

class AppLogo extends StatefulWidget
{
	@override
	State<StatefulWidget> createState() => AppLogoState();
}

class AppLogoState extends State<AppLogo> with SingleTickerProviderStateMixin
{
	AnimationController animationController;
	Animation<double> animation;

	double minWidth;
	double maxWidth;

	@override
	Widget build(BuildContext context)
	{
		minWidth = 0.85 * MediaQuery.of(context).size.width;
		maxWidth = 0.88 * MediaQuery.of(context).size.width;

		create_animation();

		return Container
		(
			height: maxWidth / 2,
			width: animation.value,
			child: Image.asset('assets/images/logo.png'),
		);
	}

	void create_animation()
	{
		animation = Tween<double>(begin: minWidth, end: maxWidth).animate(animationController)..addListener
		(()
			{
				setState((){});
			}
		);
	}

	@override void initState()
	{
		super.initState();
		create_animation_controller();
	}

	void create_animation_controller()
	{
		animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);

		animationController.addStatusListener((status)
		{
			if (status == AnimationStatus.completed)
				animationController.reverse();
			else if (status == AnimationStatus.dismissed)
				animationController.forward();
		});

		animationController.forward();
	}
}