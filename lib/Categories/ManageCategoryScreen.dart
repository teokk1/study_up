import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/AddEntityForm.dart';
import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/Questions/ManageQuestionScreen.dart';
import 'package:study_up/UnJson/UnJsons.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

class ManageCategoryScreen extends EntityManager
{
	ManageCategoryScreen(var json) : super("Upravljanje Kategorijom", json, [CategoryQuestionsTab(json['id'])]);
}

class CategoryQuestionsTab extends EntityTabWithList
{
	CategoryQuestionsTab(int categoryId) : super((j) => ManageQuestionScreen(j), "Pitanja", "categories", categoryId, "questions", UnJsonQuestionWithAnswers(UnJsonAnswerSmall()));

	void add_question_dialog(BuildContext callerContext, String groupName)
	{
		AddQuestionForm(this, "categories/${data.entityId}/add-question", callerContext).show_dialog(groupName);
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

class AddQuestionForm extends AddEntityForm
{
  	AddQuestionForm(EntityTabWithList<Widget> tab, String endPoint, BuildContext callerContext) : super(tab, endPoint, callerContext)
	{
		textFields =
		[
			TextFieldWithController("Pitanje"),

			TextFieldWithController("Odgovor 1"),
			TextFieldWithController("Odgovor 2"),
			TextFieldWithController("Odgovor 3"),
			TextFieldWithController("Odgovor 4"),

			TextFieldWithController("Točni odgovor"),
		];
	}

	@override
	map_from_fields()
	{
		Map map =
		{
			"content" : textFields[0].controller.text,
			"answers" : [textFields[1].controller.text, textFields[2].controller.text, textFields[3].controller.text, textFields[4].controller.text],
			"correctIndex" : int.parse(textFields[5].controller.text)
		};

		return map;
	}
}