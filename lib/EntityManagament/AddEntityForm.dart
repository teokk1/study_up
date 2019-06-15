
import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

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
//	final EntityTabWithList tab;

	final Function refresh;

	List<TextFieldWithController> textFields;

//	AddEntityForm(this.tab, this.endPoint, this.callerContext);
	AddEntityForm(this.refresh, this.endPoint, this.callerContext);

	Map map_from_fields();

	add(BuildContext context) async
	{
		print("ADD called");
		
		var payload = map_from_fields();

		Navigator.pop(context);

		var response = await Requests.post(payload, serverUrl + endPoint);
		
		refresh();
	}

	List<Widget> create_widgets()
	{
		List<Widget> widgets = List<Widget>();

		for(var pair in textFields)
			widgets.add(Padding(padding: EdgeInsets.all(4.0), child: pair.field));

		return widgets;
	}

	Widget create_content()
	{
		return Column(children: create_widgets(), mainAxisSize: MainAxisSize.min);
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
					content:  SingleChildScrollView(child: create_content()),
					actions: <Widget>
					[
						FlatButton(child: create_dark_text("Dodaj"), onPressed: () => add(context)),
					],
				);
			},
		);
	}
}