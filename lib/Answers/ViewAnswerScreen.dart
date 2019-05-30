import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/UnJson/UnJsons.dart';

class ViewAnswerScreen extends EntityManager
{
	ViewAnswerScreen(var json) : super("Pregled Odgovora", json, [ViewAnswerTab(json['id'])]);
}

class ViewAnswerTab extends EntityTabWithList
{
	ViewAnswerTab(int questionId) : super((j) => Container(child: Text(j['content'])), "", "", questionId, "", UnJsonAnswerManage());
}