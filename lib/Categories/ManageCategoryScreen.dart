import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/EntityManagerBase.dart';
import 'package:study_up/EntityManagament/EntityTab.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/Questions/ManageQuestionScreen.dart';
import 'package:study_up/UnJson/UnJsonManage.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class ManageCategoryScreen extends EntityManager
{
	ManageCategoryScreen(var json) : super("Upravljanje Kategorijom", json, [CategoryQuestionsTab(json['id'])]);
}

class CategoryQuestionsTab extends EntityTabWithList
{
	CategoryQuestionsTab(int categoryId) : super((j) => ManageQuestionScreen(j), "Pitanja", "categories", categoryId, "questions", (c, r) => UnJsonQuestionManage(UnJsonAnswerManage()));

	void add_question_dialog(BuildContext callerContext, String groupName)
	{
		showDialog
		(
			context: callerContext,
			builder: (context) => AddQuestionDialogContent(refresh, "categories/${data.entityId}/add-question")
		);
	}

	add_question()
	{
		add_question_dialog(state.context, "Novo pitanje");
	}

	@override
	fab()
	{
		return create_fab(Icons.add, add_question);
  	}
}

class FormFieldWrapper extends StatelessWidget
{
	String label;
	TextFormField field;
	TextEditingController controller;
	
	FormFieldWrapper(this.label, {String initialText, TextAlign textAlign: TextAlign.center})
	{
		controller = TextEditingController();
		controller.text = initialText;
		field = TextFormField
		(
			controller: controller,
			style: TextStyle(color: textColorDark, fontSize: textSizeSmall),
			decoration: text_field_decoration(label, textColorDark, Colors.black87)
		);
	}
	
	@override
	Widget build(BuildContext context)
	{
		return field;
	}
}

class AddQuestionDialogContent extends StatefulWidget
{
	final Function refresh;
	final String endPoint;
	
	AddQuestionDialogContent(this.refresh, this.endPoint);

	@override
	State<StatefulWidget> createState() => AddQuestionDialogContentState(this);
}

class AddQuestionDialogContentState extends State<AddQuestionDialogContent>
{
	AddQuestionDialogContent parent;
	
	int radioGroup = 0;
	
	FormFieldWrapper questionField;
	FlatButton addAnswerButton;
	FlatButton removeAnswerButton;
	
	List<Widget> widgets = List<Widget>();
	List<FormFieldWrapper> answerFields = List<FormFieldWrapper>();
	
	AddQuestionDialogContentState(this.parent)
	{
		create_widgets();
	}
	
	create_widgets()
	{
		widgets = List<Widget>();
		
		create_question_field();
		create_answer_fields();
		create_add_remove_buttons();
	}
	
	create_question_field()
	{
		questionField = FormFieldWrapper("Pitanje");
		widgets.add(questionField);
	}
	
	create_answer_fields()
	{
		answerFields =
		[
			FormFieldWrapper("Odgovor 1"),
			FormFieldWrapper("Odgovor 2"),
			FormFieldWrapper("Odgovor 3"),
			FormFieldWrapper("Odgovor 4"),
		];
		create_field_wrappers();
	}
	
	create_add_remove_buttons()
	{
		removeAnswerButton = FlatButton(child: Icon(Icons.remove_circle_outline, color: textColorDark,), onPressed: remove_answer);
		addAnswerButton = FlatButton(child: Icon(Icons.add_circle_outline, color: textColorDark,), onPressed: add_answer);
		
		widgets.add(Row(children: [removeAnswerButton, addAnswerButton], mainAxisAlignment: MainAxisAlignment.center));
	}
	
	create_field_wrappers()
	{
		print("Creating widgets");
		
		for(int i = 0; i < answerFields.length; i++)
		{
			widgets.add
			(
				create_field_wrapper(i, answerFields[i])
			);
		}
	}
	
	create_field_wrapper(int count, FormFieldWrapper pair)
	{
		return Theme
		(
			data: ThemeData.light(),
			child: Padding
			(
				padding: EdgeInsets.all(4.0),
				child: Row
				(
					children:
					[
						Expanded( child: pair),
						Radio(value: count, groupValue: radioGroup, onChanged: changed_selection, activeColor: darkerAccentColor)
					],
					mainAxisAlignment: MainAxisAlignment.center,
				)
			)
		);
	}
	
	void add_field(int count, FormFieldWrapper field)
	{
		answerFields.add(field);
		
		var addRemoveButtons = widgets.last;
		widgets.last = create_field_wrapper(count, field);
		widgets.add(addRemoveButtons);
	}
	
	add_answer()
	{
		setState(()
		{
			int count = answerFields.length;
			add_field(count, FormFieldWrapper("Odgovor ${count+1}"));
		});
	}
	
	remove_answer()
	{
		if(answerFields.length <= 2)
			return;
		
		setState(()
		{
			answerFields.removeLast();
			
			var addRemoveButtons = widgets.last;
			widgets.removeLast();
			widgets.last = addRemoveButtons;
		});
	}

	@override
	Widget build(BuildContext context)
	{
		return AlertDialog
		(
			backgroundColor: accentColor,
			title: create_dark_text("Novo pitanje", alignment: TextAlign.center),
			content: SingleChildScrollView(child: Column(children: widgets)),
			actions: <Widget>
			[
				FlatButton(child: create_dark_text("Dodaj"), onPressed: () => add(context)),
			],
		);
//		return Padding(padding: EdgeInsets.all(10.0), child: Column(children: widgets, mainAxisSize: MainAxisSize.min));
	}
	
	add(BuildContext context) async
	{
		print("ADD called");
		
		var payload = map_from_fields();
		
		Navigator.pop(context);
		
		var response = await Requests.post(payload, serverUrl + parent.endPoint);
		
		parent.refresh();
	}

	void changed_selection(int selectedItem)
	{
		setState(()
		{
			radioGroup = selectedItem;
			for(int i = 1; i < answerFields.length+1; i++)
			{
				var label = answerFields[i-1].label;
				var text = answerFields[i-1].controller.text;
				widgets[i] = create_field_wrapper(i-1, FormFieldWrapper(label, initialText: text));
			}
		});
	}
	
	@override
	map_from_fields()
	{
		Map map =
		{
			"content" : questionField.controller.text,
			"answers" : [],
			"correctIndex" : radioGroup
		};
		
		for(var field in answerFields)
		{
			map["answers"].add(field.controller.text);
		}
		
		return map;
	}
}