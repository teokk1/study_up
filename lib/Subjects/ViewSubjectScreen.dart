import 'package:study_up/Categories/ViewCategoryScreen.dart';
import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/UnJson/UnJsons.dart';

class ViewSubjectScreen extends EntityManager
{
	ViewSubjectScreen(var json) : super("Pregled Predmeta", json, [ViewSubjectCategoriesTab(json['id'])]);
}

class ViewSubjectCategoriesTab extends EntityTabWithList
{
	ViewSubjectCategoriesTab(int subjectId) : super((j) => ViewCategoryScreen(j), "Kategorije", "subjects", subjectId, "categories", UnJsonCategory());
}