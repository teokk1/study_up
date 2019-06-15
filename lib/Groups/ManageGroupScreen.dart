import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/AddEntityForm.dart';
import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/Subjects/ManageSubjectScreen.dart';
import 'package:study_up/UnJson/UnJsonManage.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

class ManageGroupScreen extends EntityManager
{
	ManageGroupScreen(var json) : super("Upravljanje Grupom", json, [GroupSubjectsTab(json['id']), GroupMembersTab(json['id']), GroupLeaderboardTab(json['id'])]);
}

class AddSubjectForm extends AddEntityForm
{
	AddSubjectForm(Function f, String endPoint, BuildContext callerContext) : super(f, endPoint, callerContext)
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
	GroupSubjectsTab(int groupId) : super((j) => ManageSubjectScreen(j), "Predmeti", "groups", groupId, "subjects", (c, r) => UnJsonSubjectManage(c, r));

	void add_subject_dialog(BuildContext callerContext, String groupName)
	{
		AddSubjectForm(refresh, "groups/${data.entityId}/add-subject", callerContext).show_dialog(groupName);
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

class AddMemberForm extends AddEntityForm
{
	AddMemberForm(Function f, String endPoint, BuildContext callerContext) : super(f, endPoint, callerContext)
	{
		textFields =
		[
			TextFieldWithController("Nadimak"),
		];
	}

	@override
	map_from_fields()
	{
		print(textFields[0].controller.text);
		
		Map map =
		{
			"userName" : textFields[0].controller.text,
		};
		
		return map;
	}
}

class GroupMembersTab extends EntityTabWithList
{
	GroupMembersTab(int groupId) : super((j) {}, "Članovi", "groups", groupId, "members-admins", (c, r) => UnJsonMemberManage(c, r));
	
	void add_member_dialog(BuildContext callerContext, String groupName)
	{
		AddMemberForm(refresh, "groups/${data.entityId}/add-user-from-username", callerContext).show_dialog(groupName);
	}
	
	void add_admin_dialog(BuildContext callerContext, String groupName)
	{
		AddMemberForm(refresh, "groups/${data.entityId}/add-admin-from-username", callerContext).show_dialog(groupName);
	}
	
	add_member()
	{
		add_member_dialog(state.context, "Novi Član");
	}
	
	add_admin()
	{
		add_admin_dialog(state.context, "Novi Admin");
	}
	
	initiate_member_add()
	{
		basic_dialog(state.context, "Novi član/admin", "Dodati novog člana ili novog administratora?", add_member, add_admin, yesString: "Član", noString: "Admin");
	}
	
	@override
	fab()
	{
		return create_fab(Icons.add, initiate_member_add);
	}
}

class GroupLeaderboardTab extends EntityTabWithList
{
	GroupLeaderboardTab(int groupId) : super((j) {}, "Ljestvice", "groups", groupId, "leaderboard", (c, r) => UnJsonLeaderboardManage(c, r));
}