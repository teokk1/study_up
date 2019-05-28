import 'package:flutter/material.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import 'TrainingEntity.dart';

class TrainingSetupScreen extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold
		(
			Column
			(
				mainAxisSize: MainAxisSize.min,
				children :<Widget>
				[
					create_text("Select questions from:"),
					spacing(20.0),
					TrainingGroupSelect(),
					TrainingSubjectSelect(-1),
					TrainingCategorySelect(-1),
				]
			)
		);
	}
}
