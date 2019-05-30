
import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class GroupCreator
{
	TextEditingController nameTextController = TextEditingController();
	TextEditingController passwordTextController = TextEditingController();

	BuildContext originalContext;

	GroupCreator(this.originalContext);

	static create_group(String name, String password) async
	{
		var user = UserManager.user;

		Map group =
		{
			"name": name,
			"password" : password,
//			"schoolId": user.schoolId,
		};

		return await Requests.post(group, serverUrl + "groups/create/${user.id}", emptyResponse: "Nema grupa", errorInfo: "Failed to create group.");
	}

	dialog_form()
	{
		return Column
		(
			mainAxisSize: MainAxisSize.min,
			children: <Widget>
			[
				dark_text_field("Ime", controller: nameTextController, textAlign: TextAlign.center),
//				TextField(decoration: new InputDecoration(hintText: "Name"), controller: nameTextController,), //check if taken
				spacing(10.0),
				dark_text_field("Lozinka grupe", controller: passwordTextController, textAlign: TextAlign.center),
//				TextField(decoration: new InputDecoration(hintText: "Group password"), controller: passwordTextController,), //check if taken
			],
		);
	}

	void show_dialog(BuildContext callerContext, Function onFinish)
	{
		showDialog
		(
			context: callerContext,
			builder: (BuildContext context)
			{
				return AlertDialog
				(
					backgroundColor: accentColor,
					title: create_dark_text("Create Group"),
					content: dialog_form(),
					actions: <Widget>
					[
						FlatButton(child: create_dark_text("Cancel"), onPressed: () => Navigator.pop(context)),
						FlatButton(child: create_dark_text("Create"), onPressed: () => on_click(context, onFinish)),
					],
				);
			},
		);
	}

	void on_click(BuildContext context, Function onFinish) async
	{
		var response = await create_group(nameTextController.text, passwordTextController.text);
		print(response);

		create_snackbar(originalContext, response['name']);

		onFinish();

		Navigator.pop(context);
	}
}