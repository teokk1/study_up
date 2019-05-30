import 'package:flutter/material.dart';

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