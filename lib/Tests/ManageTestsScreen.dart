import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/AddEntityForm.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/MainScreen/MainAppDrawer.dart';
import 'package:study_up/UnJson/UnJsonsComplex.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';
import 'ManageTestScreen.dart';

class ManageTestsScreen extends StatefulWidget
{
	@override
	State<StatefulWidget> createState() => ManageTestsScreenState();
}

class ManageTestsScreenState extends State<ManageTestsScreen>
{
	AsyncListView testList;
	
	ManageTestsScreenState()
	{
		recreate_list();
	}
	
	void recreate_list()
	{
		testList = AsyncListView(on_test_click, "users/${UserManager.user.id}/created-tests", UnJsonTestManage());
	}
	
	void on_test_click(var context, var json, JsonListItemState state)
	{
		navigate_to(context, ManageTestScreen(json));
	}

	void add_test(BuildContext context)
	{
		AddTestForm(refresh, "tests/create", context).show_dialog("Novi test");
	}

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold_login_required
		(
			SingleChildScrollView
			(
				padding: EdgeInsets.all(20),
				child: Column
				(
					mainAxisSize: MainAxisSize.min,
					children :<Widget>
					[
						create_text("Postojeći testovi"),
						spacing(20.0),
						testList
					]
				),
			),
			appBar: back_button_app_bar(context, "Upravljanje testovima"),
			drawer: MainAppDrawer.create(context),
			floatingActionButton: create_fab(Icons.add, () => add_test(context)),
			decoration: main_gradient_decoration()
		);
	}

	void refresh()
	{
		setState(recreate_list);
	}
}

class AddTestForm extends AddEntityForm
{
	AddTestForm(Function refresh, String endPoint, BuildContext callerContext) : super(refresh, endPoint, callerContext)
	{
		textFields =
		[
			TextFieldWithController("Naziv"),
			TextFieldWithController("Trajanje (h)"),
			TextFieldWithController("Predmet"),
//			TextFieldWithController("Grupa"),
		];
	}

	@override
	map_from_fields()
	{
		Map map =
		{
			"name" : textFields[0].controller.text,
			"timeInSeconds" : int.parse(textFields[1].controller.text) * 60 * 60,
			"creator" : UserManager.user.id,
			"subjectId" : int.parse(textFields[2].controller.text),
//			"groupId" :  int.parse(textFields[3].controller.text),
		};
		
		print(map);
		return map;
	}
}