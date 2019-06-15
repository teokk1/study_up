import 'package:flutter/material.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class SchoolScreen extends StatelessWidget
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
						create_text("Moja Škola"),
						spacing(20.0),
					]
				),
			),
			padding: mainPadding,
			decoration: main_gradient_decoration(),
		);
	}
}