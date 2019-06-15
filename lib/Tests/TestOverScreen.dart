import 'package:flutter/material.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

class TestOverScreen extends StatelessWidget
{
	int totalQuestions = 0;
	int score = 0;

	String testName;

	TestOverScreen(this.testName, this.score, this.totalQuestions);

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
					children: <Widget>
					[
						create_text("Test $testName završen!"),
						create_text("Točni odgovori: $score"),
						create_text("Ukupno pitanja: $totalQuestions"),
					]
				),
			),
		);
		}
	}