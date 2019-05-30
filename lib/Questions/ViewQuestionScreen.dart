import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/UnJson/UnJsons.dart';

class ViewQuestionScreen extends EntityManager
{
	ViewQuestionScreen(var json) : super("Pregled Pitanja", json, [ViewQuestionTab(json['id'])]);
}

class ViewQuestionTab extends EntityTabWithList
{
	ViewQuestionTab(int questionId) : super((j) => {}, "Odgovori", "questions", questionId, "answers", UnJsonAnswer());
}