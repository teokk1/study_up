import 'package:flutter/material.dart';
import 'package:study_up/Categories/ManageCategoryScreen.dart';
import 'package:study_up/EntityManagament/AddEntityForm.dart';
import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/UnJson/UnJsons.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

class ManageSubjectScreen extends EntityManager
{
	ManageSubjectScreen(var json) : super("Upravljanje Predmetom", json, [SubjectCategoriesTab(json['id'])]);
}

class SubjectCategoriesTab extends EntityTabWithList
{
	SubjectCategoriesTab(int subjectId) : super((j) => ManageCategoryScreen(j), "Kategorije", "subjects", subjectId, "categories", UnJsonCategory());

	void add_category_dialog(BuildContext callerContext, String groupName)
	{
		AddCategoryForm(this, "subjects/${data.entityId}/add-category", callerContext).show_dialog(groupName);
	}

	add_category()
	{
		add_category_dialog(state.context, "Nova kategorija");
	}

	@override
	fab()
	{
		return create_fab(Icons.add, add_category);
	}
}

class AddCategoryForm extends AddEntityForm
{
	AddCategoryForm(EntityTabWithList<Widget> tab, String endPoint, BuildContext callerContext) : super(tab, endPoint, callerContext)
	{
		textFields =
		[
			TextFieldWithController("Naziv"),
		];
	}

	@override
	map_from_fields()
	{
		Map map =
		{
			"name" : textFields[0].controller.text,
		};

		return map;
	}
}