import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/UnJson/UnJsons.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';
import 'ManageGroupScreen.dart';

class ManageGroupsScreen extends StatelessWidget
{
	ManageGroupsScreen();

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