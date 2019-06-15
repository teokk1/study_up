
import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/AddEntityForm.dart';
import 'package:study_up/HTTP/Auth.dart';
import 'package:study_up/UnJson/UnJsonsComplex.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';

class FriendsScreen extends StatefulWidget
{
	@override
	State<StatefulWidget> createState() => FriendsScreenState();
}

class FriendsScreenState extends State<FriendsScreen>
{
	AppUser user;
	FriendsScreenState()
	{
		user = UserManager.user;
	}

	refresh(AppUser newUser)
	{
		setState(() => user = newUser);
	}
	
	create_search_field(String label, String fieldLabel, TextEditingController controller)
	{
	
	}
	
	add_friend()
	{
	
	}
	
	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold_login_required
		(
			Column
			(
				children:
				[
					Container
					(
						child: AsyncListView((){}, "users/${user.id}/friends", UnJsonFriend())
					),
					
//					create_button("Spremi promjene", save_changes)
				],
				mainAxisAlignment: MainAxisAlignment.center,
				mainAxisSize: MainAxisSize.min,
			),
			padding: mainPadding,
			decoration: gradient_decoration([hex_color("#FF6696"), hex_color("#FFAC68")]),
			floatingActionButton: create_fab(Icons.person_add, add_friend),
			appBar: back_button_app_bar(context, "Moji prijatelji")
		);
	}
}

class AddFriendForm extends AddEntityForm
{
  AddFriendForm(Function refresh, String endPoint, BuildContext callerContext) : super(refresh, endPoint, callerContext);

  @override
  Map map_from_fields()
  {
  }
}