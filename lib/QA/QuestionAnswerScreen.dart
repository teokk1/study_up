import 'dart:core';

import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/QA/QAFeedback.dart';
import 'package:study_up/UnJson/UnJsonsBasic.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';

class QuestionFetcher
{
	int categoryId;
	Function fetchFunction;
	
  	int questionIndex = 0;
	List<dynamic> questions;

	QuestionFetcher(this.categoryId, this.fetchFunction);

	Future<void> fetch() async
	{
		var response = await fetchFunction(categoryId);
		questions = response;//json.decode(response);
		print(questions.toString());
	}

	Map<String, dynamic> new_question()
	{
		return questions[questionIndex++];
	}

	bool is_done()
	{
		return questionIndex == questions.length;
	}
}

class QuestionAnswerScreen extends StatefulWidget
{
	QuestionAnswerScreenState state;
	
	Function whenDone;
	
	int categoryId;
	Function fetchFunction;

	QuestionAnswerScreen(this.categoryId, this.fetchFunction, this.whenDone);

	@override
	State<StatefulWidget> createState()
	{
		this.state = QuestionAnswerScreenState(QuestionFetcher(categoryId, fetchFunction), whenDone);
		return this.state;
	}  
}

class QuestionAnswerScreenState extends State<QuestionAnswerScreen>
{
	bool canAnswer = false;
	//Questions,
	Function whenDone;

	int points = 0;
	int totalQuestions = 0;

	Text questionCount = Text("Pitanje ");
	
	Map<String, dynamic> question;
	
	QuestionFetcher fetcher;
	
	AnswerWidget answerWidget;
	Column column;
	
	QAFeedback feedback = QAFeedback("");
	
	QuestionAnswerScreenState(this.fetcher, this.whenDone)
	{
		column = Column();
	}

	@override
	void initState()
	{
		super.initState();
		init_fetcher();
	}
	
	void exit()
	{
		Navigator.pop(context);
		Navigator.pop(context);
	}
	
	create_dialog()
	{
		return AlertDialog
		(
			backgroundColor: accentColor,
			title: create_dark_text("Gotovo!"),
			actions: <Widget>
			[
				FlatButton(child: create_dark_text("Ok"), onPressed: exit),
			],
		);
	}

	void when_done()
	{
		whenDone(points, totalQuestions);
		basic_dialog(context, "Završeno!", "Točno odgovoreno $points od $totalQuestions pitanja, odnosno ${points * 100.0/totalQuestions}%", (){}, () {Navigator.pop(context); Navigator.pop(context);}, noString: "", yesString: "Ok");
	}

	void new_question()
	{
		if(fetcher.is_done())
		{
			print("fetcher done");
			when_done();
			return;
		}
		
		canAnswer = false;

		setState(()
		{
			questionCount = create_text("Pitanje ${fetcher.questionIndex + 1}");
			
			question = fetcher.new_question();
			answerWidget = AnswerWidget(on_answer_click, question['id']);
			
			column = create_column();
		});
	}
	
	void init_fetcher() async
	{
		await fetcher.fetch();
		new_question();
	}

	Future<void> process_answer(bool correct, BuildContext context, JsonListItemState jsonItem) async
	{
		if(correct)
		{
			jsonItem.update_unjson(UnJsonAnswer.CorrectUnjson());
			create_feedback("+1");
		}
		else
		{
			jsonItem.update_unjson(UnJsonAnswer.WrongUnJson());
			create_feedback("");
		}
		
		await Future.delayed(Duration(milliseconds: 150));

		setState(()
		{
			if(correct)
				points++;
			totalQuestions++;
		});
	}

	void on_answer_click(var context, var json, JsonListItemState state) async
	{
		if(canAnswer == false)
		{
			canAnswer = true;
			var response = await Requests.check_answer(question['id'], json['id']);
			await process_answer(response['correct'], context, state);
			new_question();
		}
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
					child: Center(child: questionCount),
					flex: 10
				),
				Expanded
				(
					child: Container(child: create_text(question['content']), alignment: Alignment.center),
					flex: 25
				),
				Expanded
				(
					child: answerWidget,
					flex: 60
				),
				Expanded
				(
					child: Container
					(
						alignment: Alignment.bottomCenter,
						child: Row
						(
							mainAxisAlignment: MainAxisAlignment.center,
							children:
							[
								create_text("$points"),
								create_text("/"),
								create_text("$totalQuestions")
							]
						)
					),
					flex: 10
				),
			]
		);
	}
	
	void create_feedback(String text)
	{
		setState(() {feedback = QAFeedback(text);});
	}

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold_login_required
		(
			Stack
			(
				children:
				[
					column,
					Column
					(
						mainAxisSize: MainAxisSize.max,
						children: [feedback]
					)
				]
			),
			padding: defaultPadding,
			decoration: main_gradient_decoration(),
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
				AsyncListView(on_item_click, url, UnJsonAnswer(), fixedSize: true,),
				spacing(20.0),
			]
		);
	}
}