import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/Questions/ViewQuestionScreen.dart';
import 'package:study_up/UnJson/UnJsons.dart';

class ViewCategoryScreen extends EntityManager
{
	ViewCategoryScreen(var json) : super("Pregled Kategorije", json, [ViewCategoryQuestionsTab(json['id'])]);
}

class ViewCategoryQuestionsTab extends EntityTabWithList
{
	ViewCategoryQuestionsTab(int categoryId) : super((j) => ViewQuestionScreen(j), "Pitanja", "categories", categoryId, "questions", UnJsonQuestionWithAnswers(UnJsonAnswerSmall()));
}