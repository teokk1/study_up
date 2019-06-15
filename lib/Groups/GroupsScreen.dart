import 'package:flutter/material.dart';
import 'package:study_up/Groups/ManageGroupsScreen.dart';
import 'package:study_up/MainScreen/MainAppDrawer.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import 'JoinGroupScreen.dart';
import 'ViewGroupsScreen.dart';


class GroupsScreen extends StatefulWidget
{
	@override
	State<StatefulWidget> createState() => GroupsScreenState();
}

class GroupsScreenState extends State<GroupsScreen>
{
	ViewGroupsScreen viewGroupsScreen;
	ManageGroupsScreen manageGroupsScreen;
	JoinGroupsScreen joinGroupsScreen;

	@override void initState()
	{
    	super.initState();

		manageGroupsScreen = ManageGroupsScreen();
		joinGroupsScreen = JoinGroupsScreen();
		viewGroupsScreen = ViewGroupsScreen();
  	}

	@override
	Widget build(BuildContext context)
	{
		return DefaultTabController
		(
			length: 3,
			child: basic_scaffold_login_required
			(
				create_tab_bar_view([ manageGroupsScreen, joinGroupsScreen, viewGroupsScreen,]),
				appBar: create_app_bar(),
				drawer: MainAppDrawer.create(context),
				decoration: main_gradient_decoration(),
			)
		);
	}

	create_app_bar()
	{
		return back_button_app_bar(context, "Grupe", bottom: create_tabs_text(['Upravljaj', 'Nađi', 'Pregled']));
	}
}