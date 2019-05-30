import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/UnJson/UnJsons.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';
import 'GroupCreator.dart';
import 'ManageGroupScreen.dart';

class ManageGroupsScreen extends StatefulWidget
{
	@override
	State<StatefulWidget> createState() => ManageGroupsScreenState();
}

class ManageGroupsScreenState extends State<ManageGroupsScreen>
{
	AsyncListView listView;
	GroupCreator groupCreator;

	ManageGroupsScreenState()
	{
		recreate_list_view();
	}

	static create_group(String name) async
	{
		var user = UserManager.user;

		Map group =
		{
			"name": name,
			"schoolId": user.schoolId,
		};

		return await Requests.post(group, serverUrl + "groups/create/${user.id}", emptyResponse: "Nema grupe", errorInfo: "Failed to create group.");
	}

	manage_group(var context, var json, JsonListItemState state) => navigate_to(context, ManageGroupScreen(json));

	@override
	Widget build(BuildContext context)
	{
		groupCreator = GroupCreator(context);

		return basic_scaffold
		(
			Column
			(
				mainAxisAlignment: MainAxisAlignment.start,
				children:
				[
					listView
				],
			),
			padding: EdgeInsets.all(0.0),
			floatingActionButton: create_fab(Icons.group_add, show_add_dialog),
		);
	}

	void show_add_dialog()
	{
		groupCreator.show_dialog(context, on_add_dialog_close);
	}

	void on_add_dialog_close()
	{
		setState(() => recreate_list_view());
	}

	void recreate_list_view()
	{
		listView = AsyncListView(manage_group, "users/" + UserManager.user.id  + "/groups-admin", UnJsonGroupExtended(icon: Icons.supervised_user_circle));
	}
}