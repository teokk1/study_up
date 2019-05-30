
import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';
import 'EntityTab.dart';

class TextFieldWithController
{
	TextField field;
	TextEditingController controller;

	TextFieldWithController(String label, {TextAlign textAlign: TextAlign.center})
	{
		controller = TextEditingController();
		field = dark_text_field(label, controller: controller, fontSize: textSizeSmall, textAlign: textAlign);
	}
}

abstract class AddEntityForm
{
	final String endPoint;
	final BuildContext callerContext;
	final EntityTabWithList tab;

	List<TextFieldWithController> textFields;

	AddEntityForm(this.tab, this.endPoint, this.callerContext);

	Map map_from_fields();

	add(BuildContext context) async
	{
		var payload = map_from_fields();

		Navigator.pop(context);

		var response = await Requests.post(payload, serverUrl + endPoint);

		tab.refresh();
	}

	create_fields()
	{
		List<Widget> fields = List<Widget>();

		for(var pair in textFields)
			fields.add(Padding(padding: EdgeInsets.all(4.0), child: pair.field));

		return SingleChildScrollView
		(
			child: Column(children: fields, mainAxisSize: MainAxisSize.min)
		);
	}

	void show_dialog(String title)
	{
		showDialog
		(
			context: callerContext,
			builder: (BuildContext context)
			{
				return AlertDialog
				(
					backgroundColor: accentColor,
					title: create_dark_text("$title", alignment: TextAlign.center),
					content: create_fields(),
					actions: <Widget>
					[
						FlatButton(child: create_dark_text("Dodaj"), onPressed: () => add(context)),
					],
				);
			},
		);
	}
}