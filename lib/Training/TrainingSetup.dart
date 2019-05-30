import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';
import 'TrainingEntity.dart';
import 'TrainingScreen.dart';

class TrainingSetupScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => TrainingSetupScreenState();
}

class TrainingSetupScreenState extends State<TrainingSetupScreen>
{
	TrainingGroupSelect trainingGroupSelect;
	TrainingSubjectSelect trainingSubjectSelect;
	TrainingCategorySelect trainingCategorySelect;

	int selectedGroup = -1;
	int selectedSubject = -1;
	int selectedCategory = -1;

	String selectedCategoryName = "Ništa";

	TrainingSetupScreenState()
	{
		if(UserManager.logged_in())
		{
			trainingGroupSelect = TrainingGroupSelect(on_group_click);
			trainingSubjectSelect = TrainingSubjectSelect(selectedGroup, on_subject_click);
			trainingCategorySelect = TrainingCategorySelect(selectedCategory, on_category_click);
		}
	}

	void update_subject_select(int id)
	{
		trainingSubjectSelect = TrainingSubjectSelect(id, on_subject_click);
		update_category_select(-1);
		selectedCategoryName = "Ništa";
	}

	void update_category_select(int id)
	{
		trainingCategorySelect = TrainingCategorySelect(id, on_category_click);
	}

	void on_group_click(var context, var json, JsonListItemState state)
	{
		setState(()
		{
			selectedGroup = json['id'];
			update_subject_select(selectedGroup);
		});
	}

	void on_subject_click(var context, var json, JsonListItemState state)
	{
		setState(()
		{
			selectedSubject = json['id'];
			update_category_select(selectedSubject);
		});
	}

	void on_category_click(var context, var json, JsonListItemState state)
	{
		setState(()
		{
			selectedCategory = json['id'];
			selectedCategoryName = json['name'];
		});
	}

	void on_go_click(BuildContext context)
	{
		navigate_to(context, TrainingScreen(selectedCategory));
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
						create_text("Odaberi pitanja iz"),
						spacing(20.0),
						max_height_box(0.3, context, trainingGroupSelect),
						max_height_box(0.3, context, trainingSubjectSelect),
						max_height_box(0.3, context, trainingCategorySelect),
					]
				),
			),
			bottomNavigationBar: bottom_bar(),
//			floatingActionButton: FloatingActionButton(onPressed: () => on_go_click(context)),
		);
	}

	bottom_bar()
	{
		return BottomAppBar
		(
			color: backgroundColor,
			child: Padding
			(
				padding: EdgeInsets.all(5.0),
				child: Row
				(
					mainAxisSize: MainAxisSize.min,
					mainAxisAlignment: MainAxisAlignment.spaceAround,
					children: <Widget>
					[
						create_text("Odabrano: $selectedCategoryName"),
						create_button("Kreni", () => on_go_click(context))
					],
				),			
			)
		);
	}
}
