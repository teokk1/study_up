import 'package:flutter/material.dart';
import 'package:study_up/Achievements/AchievementsScreen.dart';
import 'package:study_up/Duels/MyDuelsScreen.dart';
import 'package:study_up/Groups/GroupsScreen.dart';
import 'package:study_up/School/SchoolScreen.dart';
import 'package:study_up/Tests/ManageTestsScreen.dart';
import 'package:study_up/Tests/TestsScreen.dart';
import 'package:study_up/User/FriendsScreen.dart';
import 'package:study_up/User/UserPage.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class MainAppDrawer
{
	static groups_screen(BuildContext context) => navigate_to(context, GroupsScreen());
	
	static duels_screen(BuildContext context) => navigate_to(context, MyDuelsScreen());
	
	static tests_screen(BuildContext context) => navigate_to(context, MyTestsScreen());
	static manage_tests_screen(BuildContext context) => navigate_to(context, ManageTestsScreen());

	static achievements_screen(BuildContext context) => navigate_to(context, AchievementsScreen());
	static school_screen(BuildContext context) => navigate_to(context, SchoolScreen());
	static friends_screen(BuildContext context) => navigate_to(context, FriendsScreen());
	
	static user_screen(BuildContext context) => navigate_to(context, UserPage());
	
	static drawer_item(String title, IconData iconData, Function onTap)
	{
		return ListTile(title: text_icon(title, iconData, textColor: Colors.white), onTap: onTap);
	}

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
						
						drawer_item("Grupe", Icons.group, () => groups_screen(context)),
						
						drawer_item("Moji Dvoboji", Icons.compare_arrows,  () => duels_screen(context)),
						
						drawer_item("Moji Testovi", Icons.assignment_returned,  () => tests_screen(context)),
						drawer_item("Upravljanje Testovima", Icons.assignment, () => manage_tests_screen(context)),
						
						drawer_item("Postignuća", Icons.cake, () => achievements_screen(context)),
						drawer_item("Moja Škola", Icons.school, () => school_screen(context)),
						drawer_item("Moji Prijatelji", Icons.mood, () => friends_screen(context)),
						
						drawer_item("Moj Račun", Icons.account_circle, () => user_screen(context)),
					],
				)
			)
		);
	}
}

