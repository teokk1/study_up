import 'package:flutter/material.dart';
import 'package:study_up/Categories/ManageCategoryScreen.dart';
import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/Questions/ManageQuestionScreen.dart';
import 'package:study_up/UnJson/UnJsonsComplex.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

class ManageTestScreen extends EntityManager
{
	ManageTestScreen(var json) : super("Upravljanje Testom", json, [TestQuestionsTab(json['id'])]);
}

class TestQuestionsTab extends EntityTabWithList
{
	TestQuestionsTab(int testId) : super((j) => ManageQuestionScreen(j), "Pitanja", "tests", testId, "questions", UnJsonQuestionWithAnswers(UnJsonAnswerSmall()));

	void add_question_dialog(BuildContext callerContext, String groupName)
	{
		showDialog
		(
			context: callerContext,
			builder: (context) => AddQuestionDialogContent(refresh, "tests/${data.entityId}/add-question")
		);
	}

	add_question()
	{
		add_question_dialog(state.context, "Novo pitanje");
	}

	@override
	fab()
	{
		return create_fab(Icons.add, add_question);
	}
}