import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/UnJson/UnJsonManage.dart';

class ManageQuestionScreen extends EntityManager
{
	ManageQuestionScreen(var json) : super("Upravljanje Pitanjem", json, [ManageQuestionTab(json['id'])]);
}

class ManageQuestionTab extends EntityTabWithList
{
	ManageQuestionTab(int questionId) : super((j) => {}, "Odgovori", "questions", questionId, "answers", UnJsonAnswerManage());
}