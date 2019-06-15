import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/QA/QASetupEntity.dart';
import 'package:study_up/QA/QuestionAnswerScreen.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';

class QASetupScreen extends StatefulWidget
{
	final String title;
	final String groupEndPoint;
	final Function fetchFunction;
	final Function whenDone;
	
	QASetupScreen(this.title, this.groupEndPoint, this.fetchFunction, this.whenDone);
	
	@override
	State<StatefulWidget> createState() => QASetupScreenState(title, groupEndPoint, fetchFunction, whenDone);
	
	static qa_prep_navigate(BuildContext context, String title, String groupEndPoint, Function fetchFunction, Function whenDone)
	{
		navigate_to
		(
			context,
			QASetupScreen
			(
				title,
				groupEndPoint,
				fetchFunction,
				whenDone
			)
		);
	}
}

class QASetupScreenState extends State<QASetupScreen>
{
	final String title;
	final String groupEndPoint;
	
	final selectColor1 = transparent_white(64);
	final selectColor2 = transparent_white(128);
	
	int questionCount;

  	Function fetchFunction;
  	Function whenDone;
	
	QASetupGroupSelect groupSelect;
	QASetupSubjectSelect subjectSelect;
	QASetupCategorySelect categorySelect;

	int selectedGroup = -1;
	int selectedSubject = -1;
	int selectedCategory = -1;

	String selectedCategoryName = "Ništa";

	QASetupScreenState(this.title, this.groupEndPoint, this.fetchFunction, this.whenDone)
	{
		if(UserManager.logged_in())
		{
			groupSelect = QASetupGroupSelect(on_group_click,  groupEndPoint);
			update_group(-1);
		}
	}

	void update_subject_select()
	{
		subjectSelect = selectedGroup == -1 ? null : QASetupSubjectSelect(selectedGroup, on_subject_click);
		selectedCategoryName = "Ništa";
		update_category_select();
	}

	void update_category_select()
	{
		categorySelect = selectedSubject == -1 ? null :  QASetupCategorySelect(selectedSubject, on_category_click);
		selectedCategoryName = "Ništa";
	}
	
	void update_group(int groupId)
	{
		selectedGroup = groupId;
		selectedSubject = -1;
		selectedCategory = -1;
		update_subject_select();
	}

	void on_group_click(var context, var json, JsonListItemState state)
	{
		groupSelect.update_color(state, selectColor1, selectColor2);
		setState(()
		{
			update_group(json['id']);
		});
	}

	void on_subject_click(var context, var json, JsonListItemState state)
	{
		subjectSelect.update_color(state, selectColor1, selectColor2);
		setState(()
		{
			selectedSubject = json['id'];
			update_category_select();
		});
	}

	void on_category_click(var context, var json, JsonListItemState state)
	{
		categorySelect.update_color(state, selectColor1, selectColor2);
		setState(()
		{
			selectedCategory = json['id'];
			selectedCategoryName = json['name'];
		});
	}

	void on_go_click(BuildContext context)
	{
		if(selectedCategory == -1)
			create_snackbar(context, "Potrebno je odabrati kategoriju!");
		else
			on_go(context);
	}

	on_go(context)
	{
		navigate_to(context, QuestionAnswerScreen(selectedCategory, fetchFunction, whenDone));
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
						create_text(title),
						spacing(20.0),
						max_height_box(0.3, context, groupSelect),
						max_height_box(0.3, context, subjectSelect),
						max_height_box(0.3, context, categorySelect),
					]
				),
			),
			bottomNavigationBar: bottom_bar_text_and_button
			(
				[
					create_text("Odabrano: "),
					create_text("$selectedCategoryName")
				],
				create_button("Kreni", () => on_go_click(context), scale: 0.5, fontScale: 0.8)
			),
			padding: defaultPadding,
			decoration: main_gradient_decoration(),
		);
	}
}
