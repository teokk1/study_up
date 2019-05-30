import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/Subjects/ManageSubjectScreen.dart';
import 'package:study_up/Subjects/ViewSubjectScreen.dart';
import 'package:study_up/UnJson/UnJsons.dart';

class ViewGroupScreen extends EntityManager
{
	ViewGroupScreen(var json) : super("Pregled Grupe", json, [ViewGroupSubjectsTab(json['id']), ViewGroupMembersTab(json['id']), ViewGroupLeaderboardTab(json['id'])]);
}

class ViewGroupSubjectsTab extends EntityTabWithList
{
	ViewGroupSubjectsTab(int groupId) : super((j) => ViewSubjectScreen(j), "Predmeti", "groups", groupId, "subjects", UnJsonSubject());
}

class ViewGroupMembersTab extends EntityTabWithList
{
	ViewGroupMembersTab(int groupId) : super((j) => ManageSubjectScreen(j), "Članovi", "groups", groupId, "members", UnJsonMember());
}

class ViewGroupLeaderboardTab extends EntityTabWithList
{
	ViewGroupLeaderboardTab(int groupId) : super((j) => ManageSubjectScreen(j), "Ljestvice", "groups", groupId, "leaderboard", UnJsonLeaderboard());
}