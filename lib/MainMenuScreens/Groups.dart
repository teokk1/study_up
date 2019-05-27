import 'package:flutter/material.dart';
import 'package:study_up/HTTP/FutureWidgets.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/Manage/ManageScreen.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class GroupsWidget extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold
		(
			create_menu
			([
				FutureWidgets.future_text(Requests.school_for_user()),

				create_button("Manage", () => navigate_to(context, ManageScreen())),
				create_button("Join", () => navigate_to(context, ManageScreen())),
			])
		);
	}
}