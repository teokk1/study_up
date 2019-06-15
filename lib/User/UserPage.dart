
import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class UserPage extends StatefulWidget
{
	@override
	State<StatefulWidget> createState() => UserPageState();
}

class UserPageState extends State<UserPage>
{
	TextEditingController usernameController = new TextEditingController();
	TextEditingController nameController = new TextEditingController();

	AppUser user;
	UserPageState()
	{
		user = UserManager.user;
	}

	labeled_value_row(String label, Widget value)
	{
		return Row(children: [create_text(label), spacing(8.0), value]);
	}

	labeled_value_column(String label, Widget value)
	{
		return Column(children: [create_text(label), spacing(8.0), value]);
	}

	refresh(AppUser newUser)
	{
		setState(() => user = newUser);
	}

	save_changes() async
	{
		Map data =
		{
			"userName" : usernameController.text,
			"name" : nameController.text
		};

		var json = await Requests.post(data, serverUrl + "users/${user.id}/modify");

		print(json);

		refresh(AppUser(json));
	}

	create_text_field(String label, String fieldLabel, TextEditingController controller)
	{
		return labeled_value_column
		(
			label,
			Padding
			(
				padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
				child: text_field(fieldLabel, controller: controller, textAlign: TextAlign.center)
			),
		);
	}

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold_login_required
		(
			Column
			(
				children:
				[
					Expanded
					(
						child: Column
						(
							children:
							[
								create_text_field("Ime ", user.name, nameController),
								spacing(30.0),
								create_text_field("Nadimak ", user.username, usernameController),
								spacing(30.0),
								labeled_value_column("Email ", create_text(user.email)),
								spacing(30.0),
							]
						)
					),

					create_button("Spremi promjene", save_changes)
				],
				mainAxisAlignment: MainAxisAlignment.center,
				mainAxisSize: MainAxisSize.min,
			),
			padding: mainPadding,
			decoration: gradient_decoration([hex_color("#FF6696"), hex_color("#FFAC68")]),
			appBar: back_button_app_bar(context, "Ja")
		);
	}
}