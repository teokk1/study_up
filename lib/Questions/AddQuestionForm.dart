
import 'package:flutter/material.dart';
//

//
//abstract class AddEntityForm
//{
//	final String endPoint;
//	final BuildContext callerContext;
//
//	final Function refresh;
//
//	List<TextFieldWithController> textFields;
//
////	AddEntityForm(this.tab, this.endPoint, this.callerContext);
//	AddEntityForm(this.refresh, this.endPoint, this.callerContext);
//
//	Map map_from_fields();
//
//	add(BuildContext context) async
//	{
//		var payload = map_from_fields();
//
//		Navigator.pop(context);
//
//		var response = await Requests.post(payload, serverUrl + endPoint);
//
////		tab.refresh();
//		refresh();
//	}
//
//	void show_dialog(String title)
//	{
//		showDialog
//		(
//			context: callerContext,
//			builder: (BuildContext context)
//			{
//				return AlertDialog
//				(
//					backgroundColor: accentColor,
//					title: create_dark_text("$title", alignment: TextAlign.center),
//					content:  SingleChildScrollView(child: create_content()),
//					actions: <Widget>
//					[
//						FlatButton(child: create_dark_text("Dodaj"), onPressed: () => add(context)),
//					],
//				);
//			},
//		);
//	}
//}

class FormFieldWrapper
{
	TextFormField field;
	FormFieldValidator validator;
	TextEditingController controller;

	FormFieldWrapper(String label, this.validator, {TextAlign textAlign: TextAlign.center})
	{
		controller = TextEditingController();
		field = TextFormField(validator: validator, controller: controller, textAlign: textAlign);
	}
}

class MyCustomForm extends StatefulWidget
{
	MyCustomFormState state;
	final List<Widget> widgets;

	MyCustomForm(this.widgets);

	@override
	MyCustomFormState createState()
	{
		state = MyCustomFormState(widgets, "", null, (){});
		return state;
	}

	static field()
	{

	}
}

class MyCustomFormState extends State<MyCustomForm>
{
	int radioGroup = 1;
	// Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
	final _formKey = GlobalKey<FormState>();

	final String endPoint;
	final BuildContext callerContext;
	final Function refresh;

	List<Widget> widgets = List<Widget>();

  	MyCustomFormState(this.widgets, this.endPoint, this.callerContext, this.refresh);

  	add_child(Widget child)
	{
		setState(() => widgets.add(child));
	}

//	add_field()
//	{
////		Padding(padding: EdgeInsets.all(4.0), child: widget);
//	}

	Widget create_content()
	{
		return Column(children: widgets, mainAxisSize: MainAxisSize.min);
	}

	@override
	Widget build(BuildContext context)
	{
		return Form
		(
			key: _formKey,
			child: SingleChildScrollView(child: create_content()),
		);
	}

}