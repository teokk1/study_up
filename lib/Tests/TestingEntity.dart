
import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/UnJson/UnJsonsBase.dart';
import 'package:study_up/UnJson/UnJsonsComplex.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';

class TestingEntitySelect extends StatelessWidget
{
	final String title;
	final String endPoint;
	final UnJson unJson;
	final Function onClick;

	TestingEntitySelect(this.title, this.endPoint, this.unJson, this.onClick);

	void on_item_click(var context, var json, JsonListItemState state)
	{
		onClick(context, json, state);
	}

	Widget build(BuildContext context)
	{
		return create_card
		(
			[
				create_text(title),
				spacing(8.0),
				AsyncListView(on_item_click, endPoint, unJson)
			],
			padding: EdgeInsets.all(20.0),
		);
	}
}

class TestingGroupSelect extends TestingEntitySelect
{
	TestingGroupSelect(Function onClick) : super("Grupa", "users/${UserManager.user.id}/groups", UnJsonGroupExtended(paddingSize: 3.0, iconSize: 16.0), onClick);
}

class TestingSubjectSelect extends TestingEntitySelect
{
	TestingSubjectSelect(int groupId, Function onClick) : super("Predmet", "groups/$groupId/subjects", UnJsonSubject(paddingSize: 3.0, iconSize: 16.0), onClick);
}

class TestingTestSelect extends TestingEntitySelect
{
	TestingTestSelect(int subjectId, Function onClick) : super("Kategorija", "subjects/$subjectId/tests", UnJsonCategory(paddingSize: 3.0, iconSize: 16.0), onClick);
}