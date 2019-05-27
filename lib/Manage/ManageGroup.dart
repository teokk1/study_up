import 'package:flutter/material.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

class ManageGroupScreen extends StatelessWidget
{
	final Map<String, dynamic> json;

	ManageGroupScreen(this.json);

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold
		(
			create_text("Grupa: " + json['name']),
		);
	}
}