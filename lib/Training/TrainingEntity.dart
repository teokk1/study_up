
import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/UnJson/UnJsons.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';

class TrainingEntitySelect extends StatelessWidget
{
	final String title;
	final String endPoint;
	final UnJson unJson;
	final Function onClick;

	TrainingEntitySelect(this.title, this.endPoint, this.unJson, this.onClick);

	void on_item_click(var context, var json)
	{
		onClick(context, json);
	}

	Widget build(BuildContext context)
	{
		return create_card
		([
			create_text(title),
			spacing(20.0),
			AsyncListView(onClick, endPoint, unJson),
		]);
	}
}

class TrainingGroupSelect extends TrainingEntitySelect
{
	TrainingGroupSelect() : super("Group", "users/" + UserManager.user.id  + "/groups", UnJsonGroup(), (){});
}

class TrainingSubjectSelect extends TrainingEntitySelect
{
	TrainingSubjectSelect(int groupId) : super("Subject", "groups/$groupId/subjects", UnJsonSubject(), (){});
}

class TrainingCategorySelect extends TrainingEntitySelect
{
	TrainingCategorySelect(int groupId) : super("Category", "groups/$groupId/subjects", UnJsonSubject(), (){});
}