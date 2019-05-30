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

		return AsyncListView(join_group, url, UnJsonGroupJoin());
	}

	join_group(var context, var json, JsonListItemState state)
	{
		JoinGroupForm(json, this).show_dialog(json['name']);
		//ask for pass
		//join
	}

	filter_changed(String filter)
	{
		recreate_list_view(filter);
	}

	refresh()
	{
		recreate_list_view("");
	}

	@override void initState()
	{
    	super.initState();
		availableGroupList = create_list_view("");
  	}

	@override
	Widget build(BuildContext context)
	{
		return Column
		(
			children: <Widget>
			[
				create_text("Učlani se u grupu"),
				spacing(20.0),
				Container(child: text_field("Naziv", onChanged: filter_changed), width: percentage_width(context, 0.5)),
				spacing(20.0),
				availableGroupList,
			],
		);
	}
}

class JoinGroupForm
{
	final JoinGroupsScreenState parentState;
	final Map<String, dynamic> groupJson;
	final TextEditingController passwordTextController = TextEditingController();

	JoinGroupForm(this.groupJson, this.parentState);

	check_password(int groupId, String password) async
	{
		print(password);

		var response = await Requests.check_group_password(groupId, password);
		return response['correct'];
	}

	try_to_join(BuildContext context) async
	{
		var groupId = groupJson['id'];
		var password = passwordTextController.text;

		var response = await join_group(groupId, password);

		Navigator.pop(context);

		if(response['correct'])
		{
			parentState.refresh();
			create_snackbar(parentState.context, "Uspješno učljanjenje u grupu ${response['name']}!");
		}
		else
			create_snackbar(parentState.context, "Pogrešna lozinka za grupu ${groupJson['name']}!");
	}

	static join_group(var id, var password) async
	{
		Map credentials =
		{
			"id" : id,
			"password" : password
		};

		var future = await Requests.post(credentials, serverUrl + "users/${UserManager.user.id}/join-group");

		return future;
	}

	void show_dialog(String groupName)
	{
		showDialog
		(
			context: parentState.context,
			builder: (BuildContext context)
			{
				return AlertDialog
				(
					backgroundColor: accentColor,
					title: create_dark_text("$groupName"),
					content: dark_text_field("Lozinka", controller: passwordTextController, autoFocus: true, fontSize: textSizeSmall, textAlign: TextAlign.center),
					actions: <Widget>
					[
						FlatButton(child: create_dark_text("Učlani se"), onPressed: () => try_to_join(context)),
//						create_button("Join", () => try_to_join()),
					],
				);
			},
		);
	}
}