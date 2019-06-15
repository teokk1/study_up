import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/QA/QuestionAnswerScreen.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class DuelInfo
{
	String senderName;
	String senderId;
	String receiverId;
	int duelId;
	
	String group;
	String subject;
	String category;
	
	DuelInfo(Map<String, dynamic> message)
	{
		print(message);
		senderName = message['data']['sender'];
		senderId = message['data']['senderId'];
		receiverId = message['data']['receiverId'];
		duelId = int.parse(message['data']['duelId']);
	}
}

class DuelDialog
{
	static void accept_duel(BuildContext context, DuelInfo info) async
	{
		var questionFunction = (category) async
		{
			var questions = await UserManager.user.signalRClient.accept_duel(info.duelId, info.senderId);
			print(questions);
			return questions['value'];
		};
		
		var whenDone = (int points, int totalQuestions)
		{
			UserManager.user.signalRClient.submit_duel(info.duelId, points);
		};
		
		navigate_to(context, QuestionAnswerScreen(-1, questionFunction, whenDone));
	}
	
	static void refuse_duel(BuildContext context, DuelInfo info)
	{
		Navigator.pop(context);
	}
	
	static void show_dialog(BuildContext context, DuelInfo info)
	{
		showDialog
		(
			context: context,
			
			builder: (BuildContext context)
			{
				return AlertDialog
				(
					backgroundColor: accentColor,
					title: create_dark_text("Poziv na dvoboj!"),
					content: create_dark_text("Poziv na dvoboj od ${info.senderName}", alignment: TextAlign.center),
					actions: <Widget>
					[
						FlatButton(child: create_dark_text("Odbij"), onPressed: () => refuse_duel(context, info)),
						FlatButton(child: create_dark_text("Prihvati!"), onPressed: () => accept_duel(context, info)),
					],
				);
			}
		);
	}
}