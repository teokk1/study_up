
import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

class UserPage extends StatefulWidget
{
	@override
	State<StatefulWidget> createState() => UserPageState();
}

class UserPageState extends State<UserPage>
{
	AppUser user;
	UserPageState()
	{
		user = UserManager.user;
	}

	labeled_value_row(String label, String value)
	{
		return Row(children: [create_text(label), create_text(value)]);
	}

	labeled_value_column(String label, String value)
	{
		return Column(children: [create_text(label), create_text(value)]);
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
					labeled_value_column("Ime ", user.name),
					labeled_value_column("Nadimak ", user.username),
					labeled_value_column("Email ", user.email),
				]
			)
		);
	}
}