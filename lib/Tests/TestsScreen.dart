import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/MainScreen/MainAppDrawer.dart';
import 'package:study_up/QA/QuestionAnswerScreen.dart';
import 'package:study_up/UnJson/UnJsonsComplex.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';
import 'TestOverScreen.dart';

class MyTestsScreen extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return DefaultTabController
		(
			length: 2,
			child: basic_scaffold_login_required
			(
				create_tab_bar_view([TakeTestsScreen(), PastTestsScreen()]),
				appBar: back_button_app_bar(context, "Testovi", bottom: create_tabs_text(['Aktualni', 'Prošli'])),
				drawer: MainAppDrawer.create(context),
			)
		);
	}
}

class PastTestsScreen extends StatelessWidget
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
						AsyncListView(test_details, "users/${UserManager.user.id}/test-results", UnJsonTestResult())
					]
				),
				padding: defaultPadding,
				decoration: main_gradient_decoration()
			)
		);
	}

	test_details(context, json, JsonListItemState state)
	{

	}
}

class TakeTestsScreen extends StatelessWidget
{
	Map currentTest;
	QuestionAnswerScreen currentTestScreen;

	BuildContext context;

	List<dynamic> questions;

	int questionIndex = 0;

	@override
	Widget build(BuildContext context)
	{
		this.context = context;

		return basic_scaffold_login_required
		(
			SingleChildScrollView
			(
				padding: defaultPadding,
				child: Column
				(
					mainAxisSize: MainAxisSize.min,
					children :<Widget>
					[
						create_text("Dostupni Testovi"),
						spacing(20.0),
						AsyncListView(on_list_item_click, "users/${UserManager.user.id}/tests", UnJsonTestTake()),
					]
				),
			),
			decoration: main_gradient_decoration()
		);
	}

	test_over(int points, int totalQuestions)
	{
		Map testResult =
		{
			"userId" : UserManager.user.id,
			"testId" : currentTest['id'],
			"score" : points,
			"total" : totalQuestions
		};
		
		Requests.post(testResult, "tests/add-result");

		Navigator.pop(context);
		navigate_to(context, TestOverScreen(currentTest['name'], currentTestScreen.state.points, currentTestScreen.state.totalQuestions));
	}
	
	on_list_item_click(context, json, JsonListItemState state)
	{
		take_test_dialog(context, json);
	}

	take_test(BuildContext context, Map testJson) async
	{
		currentTest = testJson;
		var fetchFunction = (int categoryId)
		{
			return Requests.get_list(serverUrl + "tests/${testJson['id']}/questions");
		};
		
		currentTestScreen = QuestionAnswerScreen(-1, fetchFunction, test_over);

		Navigator.pop(context);
		navigate_to(context, currentTestScreen);
	}

	cancel_taking_test(BuildContext context)
	{
		Navigator.pop(context);
	}

	take_test_dialog(BuildContext callerContext, Map testJson)
	{
		showDialog
		(
			context: callerContext,
			builder: (BuildContext context)
			{
				return AlertDialog
				(
					backgroundColor: accentColor,
					title: create_dark_text("Želite li polagati test ${testJson['name']}?", alignment: TextAlign.center),
					actions: <Widget>
					[
						FlatButton(child: create_dark_text("Odustani"), onPressed: () => cancel_taking_test(context)),
						FlatButton(child: create_dark_text("Polaži"), onPressed: () => take_test(context, testJson)),
					],
				);
			},
		);
	}
}