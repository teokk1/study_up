import 'package:flutter/material.dart';

import '../Globals.dart';

class ManageGroupScreen extends StatelessWidget
{
	final Map<String, dynamic> json;

	ManageGroupScreen(this.json);

	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			backgroundColor: backgroundColor,
			body: Container
			(
				padding: defaultPadding,
				child: create_text("Grupa: " + json['name']),
			),
		);
	}
}