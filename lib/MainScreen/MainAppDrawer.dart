import 'package:flutter/material.dart';
import 'package:study_up/Groups/GroupsScreen.dart';
import 'package:study_up/User/UserPage.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class MainAppDrawer
{
	static groups_screen(BuildContext context) => navigate_to(context, GroupsScreen());
	static user_screen(BuildContext context) => navigate_to(context, UserPage());

	static create(BuildContext context)
	{
		return Drawer
		(
			child: Container
			(
				decoration: gradient_decoration([hex_color("#5E5B95"), hex_color("#5E5B95")]),
				child: ListView
				(
					padding: EdgeInsets.zero,
					children: <Widget>
					[
						Container
						(
							height: percentage_height(context, 0.12),
							child: DrawerHeader
							(
								child: create_text('Akcije'),
								decoration: gradient_decoration([hex_color("#5E5B95"), hex_color("#5E5B95")], begin: Alignment.topCenter, end: Alignment.bottomCenter),
							),
						),
						ListTile(title: text_icon("Grupe", Icons.group, textColor: Colors.white), onTap: () => groups_screen(context)),
//						ListTile(title: text_icon("Dodaj Pitanja", Icons.group), onTap: () => groups_screen(context)),
						ListTile(title: text_icon("Napravi Test", Icons.assignment), onTap: () => groups_screen(context)),
						ListTile(title: text_icon("Moj Račun", Icons.account_circle), onTap: () => user_screen(context)),
					],
				)
			)
		);
	}
}

