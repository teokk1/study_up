import 'package:flutter/material.dart';

import 'Globals.dart';

class DuelScreen extends StatefulWidget
{
	DuelScreen({Key key, this.title}) : super(key: key);

	final String title;

	@override
	DuelScreenState createState() => DuelScreenState();
}

class DuelScreenState extends State<DuelScreen>
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
						child: Column
						(

						),
					),
				),
			);
	}
}