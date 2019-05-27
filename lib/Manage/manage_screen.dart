import 'package:flutter/material.dart';

import '../Globals.dart';
import '../async_list.dart';
import 'manage_group.dart';

class UnJsonGroup extends UnJson
{
	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			create_text(json['name']),
		];
	}
}

class ManageScreen extends StatelessWidget
{
	manage_group(var context, var json) => navigate_to(context, ManageGroupScreen(json));
	
	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			backgroundColor: backgroundColor,
			body: Container
			(
				padding: defaultPadding,
				child: Container
				(
//					alignment: Alignment.topCenter,
					child: AsyncListView(manage_group, "groups", UnJsonGroup()),
//					(
//						mainAxisSize: MainAxisSize.max,
//						children: <Widget>
//						[
//							group_list_view(context)
//						],
//					)

//					child: Column
//					(
//						children: <Widget>
//						[
//							Text("Manage", style: textStyle),
//						],
//					),
				),
			),
		);
	}
}