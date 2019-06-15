import 'package:flutter/material.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class UnJson
{
	String emptyMessage = "Ništa";

	EdgeInsets margins = EdgeInsets.only(bottom: 2.0);
	BoxDecoration decoration = BoxDecoration();
	double widthFactor = 1;

	CrossAxisAlignment crossAlignment = CrossAxisAlignment.start;
	Alignment contentAlignment = Alignment.centerLeft;

	List<Widget> translate(Map<String, dynamic> json)
	{
		return [Text("Override UnJson for your class")];
	}
}

class UnJsonSinglePadded extends UnJson
{
	String key;
	IconData icon;

	double paddingSize = 18.0;
	double iconSize = 18.0;
	double textSize = textSizeMedium;
	
	Color color1;
	Color color2;

	TextAlign textAlignment;

	MainAxisAlignment mainAlign;

	EdgeInsets padding;

	UnJsonSinglePadded
	(
		this.key, {this.color1, this.color2, this.icon = Icons.group,
		this.paddingSize = 20.0, this.iconSize = 50.0, this.textSize = textSizeMedium,
		this.textAlignment = TextAlign.start, this.mainAlign = MainAxisAlignment.spaceBetween}
	)
	{
		emptyMessage = "Ništa";
		
		if(color1 == null)
			color1 = transparent_white(32);
		
		if(color2 == null)
			color2 = transparent_white(64);
		
		this.decoration = gradient_decoration([color1, color2]);
//		this.decoration = gradient_decoration([hex_color("#FF6598"), hex_color("#FFAA69")], borderRadius: 4.0);

		padding = EdgeInsets.all(paddingSize);
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			Container
			(
				margin: margins,
				decoration: decoration,
				child: Padding
				(
					padding: padding,
					child: Row
					(
						mainAxisSize: MainAxisSize.max,
						mainAxisAlignment: mainAlign,
						children: create_children(json),
					)
				)
			),
		];
	}

	List<Widget> create_children(Map<String, dynamic>  json)
	{
		return
		[
			Icon(icon, color: Colors.white, size: iconSize),
			SizedBox(width: 10.0),
			Expanded
			(
				child: Wrap
				(
					children:
					[
						create_text(json[key], alignment: textAlignment, size: textSize)
					]
				)
			),
		];
	}
}