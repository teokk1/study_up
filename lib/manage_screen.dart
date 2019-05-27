import 'package:flutter/material.dart';
import 'dart:async';

import 'Globals.dart';
import 'HTTP/Group.dart';

class ManageScreen extends StatefulWidget
{
	ManageScreen({Key key, this.title}) : super(key: key);

	final String title;

	@override
	ManageScreenState createState() => ManageScreenState();
}

class ManageScreenState extends State<ManageScreen>
{
	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			backgroundColor: Colors.amber,
			body: Padding
			(
				padding: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0),
				child: Align
				(
					alignment: Alignment.topCenter,
					child: group_list_view(context),
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