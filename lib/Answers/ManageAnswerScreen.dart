import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/UnJson/UnJsonManage.dart';

class ManageAnswerScreen extends EntityManager
{
	ManageAnswerScreen(var json) : super("Upravljanje Odgovorom", json, [ManageAnswerTab(json['id'])]);
}

class ManageAnswerTab extends EntityTabWithList
{
	ManageAnswerTab(int questionId) : super((j) => Container(child: Text(j['content'])), "Odgovor", "questions", questionId, "answers", UnJsonAnswerManage());
}