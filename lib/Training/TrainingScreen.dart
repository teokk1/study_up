import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/UnJson/UnJsons.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';

class TrainingScreen extends StatefulWidget
{
	final int categoryId;
	TrainingScreen(this.categoryId);

	@override
	State<StatefulWidget> createState() => TrainingScreenState(categoryId);
}

class TrainingScreenState extends State<TrainingScreen>
{
	int points = 0;

	int categoryId;

	Text questionText;
	AnswerWidget answerWidget;
	Column column;

	var question;

	TrainingScreenState(this.categoryId)
	{
		column = Column();
	}

	void new_question() async
	{
		question = await Requests.random_question(categoryId);

		setState(()
		{
			questionText = create_text(question['content']);
			answerWidget = AnswerWidget(on_answer_click, question['id']);

			column = create_column();
		});
	}

	void process_answer(bool correct, BuildContext context, JsonListItemState jsonItem)
	{
		if(correct)
		{
//			create_snackbar(context, "Točno!");
			jsonItem.update_unjson(UnJsonAnswer.CorrectUnjson());

			setState(()
			{
			  points++;
			});
		}
		else
		{
//			create_snackbar(context, "Pogrešno!");
			jsonItem.update_unjson(UnJsonAnswer.WrongUnJson());
		}
	}

	void on_answer_click(var context, var json, JsonListItemState state) async
	{
		var response = await Requests.check_answer(question['id'], json['id']);
		process_answer(response['correct'], context, state);
		new_question();
	}

	@override
	void initState()
	{
		super.initState();
		new_question();
	}

	create_column()
	{
		return Column
		(
			mainAxisSize: MainAxisSize.min,
			mainAxisAlignment: MainAxisAlignment.spaceAround,
			crossAxisAlignment: CrossAxisAlignment.center,
			children :<Widget>
			[
				Expanded
				(
					child: Container(child: questionText, alignment: Alignment.center),
					flex: 25
				),
				Expanded
				(
//					alignment: Alignment.center,
					child: answerWidget,
					flex: 50
				),
				Expanded
				(
					child: Container(child: create_text("Bodovi: $points"), alignment: Alignment.bottomCenter),
					flex: 25
				),
			]
		);
	}

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold_login_required
		(
			column
		);
	}
}

class AnswerWidget extends StatelessWidget
{
	final Function onItemClick;
	final int futureQuestionId;

	AnswerWidget(this.onItemClick, this.futureQuestionId);

	on_item_click(var context, var json, JsonListItemState state)
	{
		onItemClick(context, json, state);
	}

	@override
	Widget build(BuildContext context)
	{
		var url = "questions/$futureQuestionId/answers";
		print(url);

		return Column
		(
			mainAxisSize: MainAxisSize.max,
			children :<Widget>
			[
				AsyncListView(on_item_click, "questions/$futureQuestionId/answers", UnJsonAnswer(), fixedSize: true,),
				spacing(20.0),
			]
		);
	}
}