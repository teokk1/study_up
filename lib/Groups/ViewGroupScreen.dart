import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/Subjects/ViewSubjectScreen.dart';
import 'package:study_up/UnJson/UnJsonsBasic.dart';
import 'package:study_up/UnJson/UnJsonsComplex.dart';

class ViewGroupScreen extends EntityManager
{
	ViewGroupScreen(var json) : super("Pregled Grupe", json, [ViewGroupSubjectsTab(json['id']), ViewGroupMembersTab(json['id']), ViewGroupLeaderboardTab(json['id'])]);
}

class ViewGroupSubjectsTab extends EntityTabWithList
{
	ViewGroupSubjectsTab(int groupId) : super((j) => ViewSubjectScreen(j), "Predmeti", "groups", groupId, "subjects", (r, c) => UnJsonSubject());
}

class ViewGroupMembersTab extends EntityTabWithList
{
	ViewGroupMembersTab(int groupId) : super((j) {}, "Članovi", "groups", groupId, "members-admins", (r, c) => UnJsonMemberAdmin());
}

class ViewGroupLeaderboardTab extends EntityTabWithList
{
	ViewGroupLeaderboardTab(int groupId) : super((j) {}, "Ljestvice", "groups", groupId, "leaderboard", (r, c) =>  UnJsonLeaderboard());
}