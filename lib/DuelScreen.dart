import 'package:flutter/material.dart';

import 'Globals.dart';
import 'SignalR/SignalRTest.dart';

class DuelScreen extends StatelessWidget
{
	@override
	Widget build(BuildContext context)
	{
		SignalRTest sR = SignalRTest();
		sR.test_connection();

		return Scaffold
		(
			backgroundColor: backgroundColor,
			body: Padding
			(
				padding: defaultPadding,
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