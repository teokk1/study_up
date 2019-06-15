import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import '../Globals.dart';

class QAFeedback extends StatelessWidget
{
	final MultiTrackTween tween = MultiTrackTween
	([
//		Track("size").add(Duration(seconds: 4), Tween(begin: 0.0, end: 150.0)),
		
		Track("opacity")
			.add(Duration(seconds: 250), Tween(begin: 0, end: 255), curve: Curves.easeIn)
			.add(Duration(seconds: 500), Tween(begin: 255, end: 255), curve: Curves.easeIn)
			.add(Duration(seconds: 250), Tween(begin: 255, end: 0), curve: Curves.easeIn),
		
		Track("position")
			.add(Duration(milliseconds: 180), Tween(begin: 0, end: 350), curve: Curves.easeIn)
			.add(Duration(milliseconds: 500), Tween(begin: 200, end: 200))
			.add(Duration(milliseconds: 250), Tween(begin: 200, end: -1000), curve: Curves.easeOut)
	]);
	
	final String text;
	QAFeedback(this.text);
	
	@override
	Widget build(BuildContext context)
	{
		return buildAnimation(context);
	}
	
	Widget buildAnimation(BuildContext context)
	{
		var animation = ControlledAnimation
		(
			playback: Playback.START_OVER_FORWARD,
			duration: tween.duration,
			tween: tween,
			builder: (context, animation)
			{
				return Transform.translate
				(
					offset: Offset(0.0, animation["position"].toDouble()),
					child: Center(child: Text(text, style: TextStyle(fontSize: textSizeLarge))),
				);
			},
		);
		
		return animation;
	}
}