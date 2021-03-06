
import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/UnJson/UnJsonsComplex.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';
import 'ViewGroupScreen.dart';

class ViewGroupsScreen extends StatelessWidget
{
	ViewGroupsScreen();

	view_group(var context, var json, JsonListItemState state) => navigate_to(context, ViewGroupScreen(json));

	@override
	Widget build(BuildContext context)
	{
		return Column
		(
			mainAxisAlignment: MainAxisAlignment.start,
			children: <Widget>
			[
				spacing(10.0),
				AsyncListView(view_group, "users/" + UserManager.user.id + "/groups", UnJsonGroupExtended())
			]
		);
	}
}