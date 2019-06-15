import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/QA/QASetup.dart';
import 'package:study_up/UnJson/UnJsonsComplex.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';

class DuelChooseOpponentScreen extends StatelessWidget
{
 	create_questions()
	{
	
	}
	
	void on_opponent_click(var context, var json, JsonListItemState state)
	{
		var senderId = UserManager.user.id;
		var receiverId = json['id'];
		var title = "Priprema dvoboja";
		var groupEndPoint = "groups/cross/$senderId/vs/$receiverId";
		var questionCount = 10;
		
		var questionFunction = (selectedCategory) async
		{
			print("Sending request for questions");
			var response = await UserManager.user.signalRClient.start_duel(receiverId, selectedCategory, questionCount);
			print("Received response: " + response.toString());
			UserManager.duelHack = response['value']['duelId'];
			await UserManager.user.signalRClient.send_duel_request(UserManager.duelHack, json['id']);
			return response['value']['questions'];
		};
		
		var whenDone = (int points, int totalQuestions)
		{
			UserManager.user.signalRClient.submit_duel(UserManager.duelHack, points);
		};
		
		QASetupScreen.qa_prep_navigate(context, title, groupEndPoint, questionFunction, whenDone);
	}

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold_login_required
		(
			Align
			(
				alignment: Alignment.topCenter,
				child: Column
				(
					children:
					[
						create_text("Izaberi protivnika!"),
						spacing(20.0),
						AsyncListView(on_opponent_click, "users", UnJsonMember()),
					]
				),
			),
			padding: mainPadding,
			decoration: main_gradient_decoration(),
		);
	}
}