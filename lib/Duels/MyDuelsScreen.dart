import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/MainScreen/MainAppDrawer.dart';
import 'package:study_up/UnJson/UnJsonsComplex.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';

class MyDuelsScreen extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return DefaultTabController
		(
			length: 2,
			child: basic_scaffold_login_required
			(
				create_tab_bar_view([OngoingDuelsScreen(), PastDuelsScreen()]),
				appBar: back_button_app_bar(context, "Dvoboji", bottom: create_tabs_text(['Aktualni', 'Prošli'])),
				drawer: MainAppDrawer.create(context),
			)
		);
	}
}

class OngoingDuelsScreen extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return DefaultTabController
		(
			length: 2,
			child: basic_scaffold_login_required
			(
				Column
				(
					mainAxisSize: MainAxisSize.min,
					children :<Widget>
					[
						create_text("Rezultati"),
						spacing(20.0),
						AsyncListView(duel_details, "duels/current/${UserManager.user.id}", UnJsonDuel())
					]
				),
				padding: defaultPadding,
				decoration: main_gradient_decoration()
			)
		);
	}
	
	duel_details(context, json, JsonListItemState state)
	{
	
	}
}


class PastDuelsScreen extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return DefaultTabController
		(
			length: 2,
			child: basic_scaffold_login_required
			(
				Column
				(
					mainAxisSize: MainAxisSize.min,
					children :<Widget>
					[
						create_text("Rezultati"),
						spacing(20.0),
						AsyncListView(duel_details, "duels/finished/${UserManager.user.id}", UnJsonDuel())
					]
				),
				padding: defaultPadding,
				decoration: main_gradient_decoration()
			)
		);
	}
	
	duel_details(context, json, JsonListItemState state)
	{
	
	}
}