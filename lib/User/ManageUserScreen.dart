import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/UnJson/UnJsons.dart';

class ManageUserScreen extends EntityManager
{
	ManageUserScreen(var json) : super("Upravljanje Korisnikom", json, [UserScreenTab(json['id'])]);
}

class UserScreenTab extends EntityTabWithList
{
	UserScreenTab(int categoryId) : super((j) => ManageUserScreen(j), "Kategorije", "subjects", categoryId, "categories", UnJsonCategory());
}