
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_up/MainScreen/MainAppDrawer.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import 'EntityTab.dart';

class EntityManager extends StatelessWidget
{
	final String entityName;
	final int tabCount;
	final Map<String, dynamic> json;

	final List<EntityTab> tabs;

	EntityManager(this.entityName, this.json, this.tabs) : tabCount = tabs.length;

	@override
	Widget build(BuildContext context)
	{
		return DefaultTabController
		(
			length: tabCount,
			child: basic_scaffold_login_required
			(
				create_tab_bar_view(tabs),
				appBar: create_app_bar(context),
				drawer: MainAppDrawer.create(context),
				decoration: main_gradient_decoration(),
			)
		);
	}

	AppBar create_app_bar(BuildContext context)
	{
		return back_button_app_bar(context, "$entityName ${object_title()}", bottom: tab_texts());
	}

	tab_texts()
	{
		List<String> headers = List<String>();

		for(EntityTab tab in tabs)
			headers.add(tab.header);

		return create_tabs_text(headers);
	}

	object_title()
	{
		if(json['name'] == null)
			return "";

		return json['name'];
	}
}