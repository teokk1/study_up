import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/AddEntityForm.dart';
import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/Subjects/ManageSubjectScreen.dart';
import 'package:study_up/UnJson/UnJsons.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

class ManageGroupScreen extends EntityManager
{
	ManageGroupScreen(var json) : super("Upravljanje Grupom", json, [GroupSubjectsTab(json['id']), GroupMembersTab(json['id']), GroupLeaderboardTab(json['id'])]);
}

class AddSubjectForm extends AddEntityForm
{
	AddSubjectForm(EntityTabWithList<Widget> tab, String endPoint, BuildContext callerContext) : super(tab, endPoint, callerContext)
	{
		textFields =
		[
			TextFieldWithController("Naziv"),
		];
	}

	@override
	map_from_fields()
	{
		Map map =
		{
			"name" : textFields[0].controller.text,
		};

		return map;
	}
}

class GroupSubjectsTab extends EntityTabWithList
{
	GroupSubjectsTab(int groupId) : super((j) => ManageSubjectScreen(j), "Predmeti", "groups", groupId, "subjects", UnJsonSubject());

	void add_subject_dialog(BuildContext callerContext, String groupName)
	{
		AddSubjectForm(this, "groups/${data.entityId}/add-subject", callerContext).show_dialog(groupName);
	}

	add_subject()
	{
		add_subject_dialog(state.context, "Novi predmet");
	}

	@override
	fab()
	{
		return create_fab(Icons.add, add_subject);
	}
}

class GroupMembersTab extends EntityTabWithList
{
	GroupMembersTab(int groupId) : super((j) => ManageSubjectScreen(j), "Članovi", "groups", groupId, "members", UnJsonMember());
}

class GroupLeaderboardTab extends EntityTabWithList
{
	GroupLeaderboardTab(int groupId) : super((j) => ManageSubjectScreen(j), "Ljestvice", "groups", groupId, "leaderboard", UnJsonLeaderboard());
}