import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/UnJson/UnJsons.dart';

class ViewUserScreen extends EntityManager
{
	ViewUserScreen(var json) : super("Profil korisnika", json, [ViewUserScreenTab(json['id'])]);
}

class ViewUserScreenTab extends EntityTabWithList
{
	ViewUserScreenTab(int categoryId) : super((j) => ViewUserScreen(j), "Kategorije", "subjects", categoryId, "categories", UnJsonCategory());
}