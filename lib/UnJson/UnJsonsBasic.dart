import 'package:flutter/material.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';
import 'UnJsonsBase.dart';

class UnJsonGroup extends UnJson
{
	UnJsonGroup()
	{
		emptyMessage = "Nema grupa";
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			create_text(json['name']),
		];
	}
}

class UnJsonQuestion extends UnJson
{
	UnJsonQuestion()
	{
		emptyMessage = "Greška pri dohvatu";
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			Padding
			(
				padding: EdgeInsets.all(10.0),
				child: create_text(json['content']),
			)
		];
	}
}

class UnJsonAnswer extends UnJsonSinglePadded
{
	UnJsonAnswer({double paddingSize = 4.0, CrossAxisAlignment crossAlignment = CrossAxisAlignment.start, TextAlign textAlignment = TextAlign.center, double iconSize = 25.0})
			: super("content", paddingSize: paddingSize, textAlignment: textAlignment, icon: Icons.arrow_right, iconSize: iconSize)
	{
		emptyMessage = "Greška pri dohvatu";

		margins = EdgeInsets.only(bottom: 2.0);
		decoration = gradient_decoration([transparent_white(32), transparent_white(64)]);
		widthFactor = 1;

		contentAlignment = Alignment.center;

		this.crossAlignment = crossAlignment;
	}

	static CorrectUnjson()
	{
		var unJson = new UnJsonAnswer();
		unJson.decoration = gradient_decoration([hex_color("#24FE41"), hex_color("#FDFC47")]);
		return unJson;
	}

	static WrongUnJson()
	{
		var unJson = new UnJsonAnswer();
		unJson.decoration = gradient_decoration([hex_color("#cb2d3e"), hex_color("#ef473a")]);
		return unJson;
	}
}

class UnJsonLeaderboard extends UnJson
{

}

class UnJsonTest extends UnJson
{

}

class UnJsonAchievement extends UnJson
{
	UnJsonAchievement()
	{
		emptyMessage = "Nemate postignuća :(";
	}
}