import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';
import 'ManageGroup.dart';

class UnJsonGroup extends UnJson
{
	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			create_text(json['name']),
		];
	}
}

class ManageScreen extends StatelessWidget
{
	ManageScreen();

	manage_group(var context, var json) => navigate_to(context, ManageGroupScreen(json));

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold
		(
			Column
			(
				children: <Widget>
				[
					create_text("Manage Groups:"),
					AsyncListView(manage_group, "/users/" + UserManager.user.id  + "/groups", UnJsonGroup()),
					//Spacer(flex: 1),
				],
			)
		);
	}
}