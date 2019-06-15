import 'package:flutter/material.dart';
import 'package:study_up/UnJson/UnJsonsBasic.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';

class AchievementsScreen extends StatelessWidget
{
	click()
	{

	}

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold_login_required
		(
			Align
			(
				alignment: Alignment.topCenter,
				child: Column
				(
					children:
					[
						create_text("Moja postignuća"),
						spacing(20.0),
						AsyncListView(click, "achievements", UnJsonAchievement()),
					]
				),
			),
			padding: mainPadding,
			decoration: gradient_decoration([hex_color("#2193b0"), hex_color("#6dd5ed")]),
			appBar: back_button_app_bar(context, "Moja postignuća")
		);
	}
}