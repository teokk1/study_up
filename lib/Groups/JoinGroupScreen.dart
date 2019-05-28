import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/UnJson/UnJsons.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';

class JoinGroupsScreen extends StatefulWidget
{
	@override
	State<StatefulWidget> createState() => JoinGroupsScreenState();
}

class JoinGroupsScreenState extends State<JoinGroupsScreen>
{
	AsyncListView availableGroupList;

	recreate_list_view(String filter)
	{
		setState(()
		{
			availableGroupList = create_list_view(filter);
		});
	}

	create_list_view(String filter)
	{
		String url = "users/${UserManager.user.id}/joinable-groups";

		if(filter.length > 0)
			url += "/$filter";

		return AsyncListView(join_group, url, UnJsonGroup());
	}

	join_group(var context, var json)
	{
		JoinGroupForm(json, context).show_dialog();
		//ask for pass
		//join
	}

	filter_changed(String filter)
	{
		recreate_list_view(filter);
	}

	@override void initState()
	{
    	super.initState();
		availableGroupList = create_list_view("");
  	}

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold
		(
			Column
			(
				children: <Widget>
				[
					create_text("Join Group:"),
					TextField
					(
						decoration: InputDecoration(border: InputBorder.none, hintText: ''),
						onChanged: filter_changed,
					),
					availableGroupList,
					//Spacer(flex: 1),
				],
			)
		);
	}
}

class JoinGroupForm
{
	final BuildContext callerContext;
	final Map<String, dynamic> groupJson;
	final TextField textField = TextField();

	JoinGroupForm(this.groupJson, this.callerContext);

	try_to_join() async
	{
		var password = textField.toString();
		print(password);

		var response = await Requests.check_group_password(groupJson['id'], password);

		if(response['correct'] == true)
			create_snackbar(callerContext, "Joined group ${groupJson['name']}!");
		else
			create_snackbar(callerContext, "Invalid password for group ${groupJson['name']}!");
	}

	void show_dialog()
	{
		showDialog
		(
			context: callerContext,
			builder: (BuildContext context)
			{
				// return object of type Dialog
				return AlertDialog
				(
					backgroundColor: accentColor,
					title: create_dark_text("Group password:"),
					content: textField,
					actions: <Widget>
					[
						FlatButton(child: create_dark_text("Join"),onPressed: () => try_to_join()),
//						create_button("Join", () => try_to_join()),
					],
				);
			},
		);
	}
}