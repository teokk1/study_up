
import 'package:flutter/material.dart';
import 'package:study_up/UnJson/UnJsonsBase.dart';
import 'package:study_up/UnJson/UnJsonsComplex.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';

class QASetupEntitySelect extends StatelessWidget
{
	final String title;
	final String endPoint;
	final UnJson unJson;
	final Function onClick;
	
	JsonListItemState previouslyClicked;

	QASetupEntitySelect(this.title, this.endPoint, this.unJson, this.onClick);

	void on_item_click(var context, var json, JsonListItemState state)
	{
		onClick(context, json, state);
		previouslyClicked = state;
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
	
	void update_color(JsonListItemState state, Color color1, Color color2)
	{
	}
}

class QASetupGroupSelect extends QASetupEntitySelect
{
	QASetupGroupSelect(Function onClick, String endPoint) : super("Grupa", endPoint, UnJsonGroupExtended(paddingSize: 3.0, iconSize: 16.0), onClick);
	
	@override void update_color(JsonListItemState state, Color color1, Color color2)
	{
		if(previouslyClicked != null)
			previouslyClicked.update_unjson(UnJsonGroupExtended(paddingSize: 3.0, iconSize: 16.0));
		state.update_unjson(UnJsonGroupExtended(paddingSize: 3.0, iconSize: 16.0, color1: color1, color2: color2));
	}
}

class QASetupSubjectSelect extends QASetupEntitySelect
{
	QASetupSubjectSelect(int groupId, Function onClick) : super("Predmet", "groups/$groupId/subjects", UnJsonSubject(paddingSize: 3.0, iconSize: 16.0), onClick);
	
	@override void update_color(JsonListItemState state, Color color1, Color color2)
	{
		if(previouslyClicked != null)
			previouslyClicked.update_unjson(UnJsonSubject(paddingSize: 3.0, iconSize: 16.0));
		state.update_unjson(UnJsonSubject(paddingSize: 3.0, iconSize: 16.0, color1: color1, color2: color2));
	}
}

class QASetupCategorySelect extends QASetupEntitySelect
{
	QASetupCategorySelect(int subjectId, Function onClick) : super("Kategorija", "subjects/$subjectId/categories", UnJsonCategory(paddingSize: 3.0, iconSize: 16.0), onClick);
	
	@override void update_color(JsonListItemState state, Color color1, Color color2)
	{
		if(previouslyClicked != null)
			previouslyClicked.update_unjson(UnJsonCategory(paddingSize: 3.0, iconSize: 16.0));
		state.update_unjson(UnJsonCategory(paddingSize: 3.0, iconSize: 16.0, color1: color1, color2: color2));
	}
}