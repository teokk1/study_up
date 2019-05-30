import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/AddEntityForm.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';

class UnJson
{
	String emptyMessage = "Empty";

	EdgeInsets margins = EdgeInsets.only(bottom: 2.0);
	BoxDecoration decoration = BoxDecoration();
	double widthFactor = 1;

	CrossAxisAlignment crossAlignment = CrossAxisAlignment.start;
	Alignment contentAlignment = Alignment.centerLeft;

	List<Widget> translate(Map<String, dynamic> json)
	{
		return [Text("Override UnJson for your class")];
	}
}

class UnJsonGroup extends UnJson
{
	UnJsonGroup()
	{
		emptyMessage = "No groups";
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			create_text(json['name']),
		];
	}
}

class UnJsonGroupJoin extends UnJson
{
	UnJsonGroupJoin()
	{
		emptyMessage = "No groups";
		contentAlignment = Alignment.center;
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			Container
			(
				decoration: gradient_decoration([transparent_white(16), transparent_white(8)]),
				child: Padding
				(
					padding: EdgeInsets.all(10.0),
					child: Row
					(
						mainAxisSize: MainAxisSize.max,
						mainAxisAlignment: MainAxisAlignment.center,
						children:
						[
							create_text(json['name'], alignment: TextAlign.center),
						],
					)
				)				
			)
		];
	}
}

class UnJsonGroupExtended extends UnJson
{
	IconData icon;

	double paddingSize = 18.0;
	double iconSize = 18.0;

	UnJsonGroupExtended({IconData icon = Icons.group, double paddingSize = 20.0, double iconSize = 50.0})
	{
		this.icon = icon;

		this.paddingSize = paddingSize;
		this.iconSize = iconSize;

		emptyMessage = "No groups";
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			Container
			(
				margin: EdgeInsets.all(2.0),
				decoration: gradient_decoration([transparent_white(32), transparent_white(64)]),
				child: Padding
				(
					padding: EdgeInsets.all(paddingSize),
					child: Row
					(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						mainAxisSize: MainAxisSize.max,
						children:
						[
							create_text(json['name']),
							Icon(icon, color: Colors.white, size: iconSize),
						],
					)
				)

			),
		];
	}
}

class UnJsonSubject extends UnJson
{
	double paddingSize = 18.0;
	double iconSize = 18.0;

	UnJsonSubject({double paddingSize = 18.0, double iconSize = 50.0})
	{
		this.paddingSize = paddingSize;
		this.iconSize = iconSize;

		emptyMessage = "No subjects";
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			Container
			(
				margin: EdgeInsets.all(2.0),
				decoration: gradient_decoration([transparent_white(32), transparent_white(64)]),
				child: Padding
				(
					padding: EdgeInsets.all(paddingSize),
					child: Row
					(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						mainAxisSize: MainAxisSize.max,
						children:
						[
							create_text(json['name']),
							Icon(Icons.lightbulb_outline, color: Colors.white, size: iconSize),
						],
					)
				)
			),
		];
	}
}

class UnJsonCategory extends UnJson
{
	double paddingSize = 18.0;
	double iconSize = 18.0;

	UnJsonCategory({double paddingSize = 18.0, double iconSize = 50.0})
	{
		this.paddingSize = paddingSize;
		this.iconSize = iconSize;

		emptyMessage = "No categories";
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			Container
			(
				margin: EdgeInsets.all(2.0),
				decoration: gradient_decoration([transparent_white(32), transparent_white(64)]),
				child: Padding
				(
					padding: EdgeInsets.all(paddingSize),
					child: Row
					(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						mainAxisSize: MainAxisSize.max,
						children:
						[
							create_text(json['name']),
							Icon(Icons.category, color: Colors.white, size: iconSize),
						],
					)
				)
			),
		];
	}
}


class UnJsonMember extends UnJson
{
	UnJsonMember()
	{
		emptyMessage = "Nema članova";
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			create_text(json['userName']),
		];
	}
}

class UnJsonLeaderboard extends UnJson
{

}

class UnJsonQuestion extends UnJson
{
	UnJsonQuestion()
	{
		emptyMessage = "Error Getting Answer";
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			Padding
			(
				padding: EdgeInsets.all(10.0),
				child: create_text(json['content']),
			)
		];
	}
}

class UnJsonQuestionWithAnswers extends UnJson implements AsyncListViewParent
{
	UnJson unJsonAnswer;
	UnJsonQuestionWithAnswers(this.unJsonAnswer)
	{
		emptyMessage = "Greška u dohvatu pitanja";
		decoration = gradient_decoration([transparent_white(32), transparent_white(32)]);
		margins = EdgeInsets.all(10);
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		var endPoint = "questions/${json['id']}/answers";

		return
		[
			Padding
			(
				padding: EdgeInsets.all(10.0),
				child: Column
				(
					mainAxisSize: MainAxisSize.min,
					children:
					[
						create_text(json['content']),
						spacing(10.0),
						AsyncListView(on_list_item_click, endPoint, unJsonAnswer),
					]
				)
			)
		];
	}

	@override
	on_list_item_click(context, json, JsonListItemState state)
	{

	}
}

class UnJsonAnswer extends UnJson
{
	UnJsonAnswer()
	{
		emptyMessage = "Error Getting Answer";

		margins = EdgeInsets.only(bottom: 2.0);
		decoration = gradient_decoration([transparent_white(32), transparent_white(64)]);
		widthFactor = 1;
		contentAlignment = Alignment.center;
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			Padding
			(
				padding: EdgeInsets.all(10.0),
				child: create_text(json['content'], alignment: TextAlign.center),
			)
		];
	}

	static CorrectUnjson()
	{
		var unJson = new UnJsonAnswer();

		unJson.decoration = gradient_decoration([correctColor, correctColor]);

		return unJson;
	}

	static WrongUnJson()
	{
		var unJson = new UnJsonAnswer();

		unJson.decoration = gradient_decoration([wrongColor, wrongColor]);

		return unJson;
	}
}

class UnJsonAnswerManage extends UnJson
{
	TextFieldWithController textField;

	UnJsonAnswerManage()
	{
		emptyMessage = "Error Getting Answer";

		margins = EdgeInsets.only(bottom: 2.0);
		decoration = gradient_decoration([transparent_white(32), transparent_white(64)]);
		widthFactor = 1;
		contentAlignment = Alignment.center;
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
//		textField = TextFieldWithController(json['content'] == null ? "" : json['content']);

		return
		[
			Padding
			(
				padding: EdgeInsets.all(10.0),
				child: create_text(json['content'])
			)
		];
	}
}

class UnJsonAnswerSmall extends UnJson
{
	TextFieldWithController textField;

	UnJsonAnswerSmall()
	{
		emptyMessage = "Error Getting Answer";

		margins = EdgeInsets.only(bottom: 2.0);
		decoration = gradient_decoration([transparent_white(16), transparent_white(16)]);
		widthFactor = 1;
		crossAlignment = CrossAxisAlignment.start;
		contentAlignment = Alignment.centerLeft;
	}

	@override List<Widget> translate(Map<String, dynamic> json)
	{
//		textField = TextFieldWithController(json['content'] == null ? "" : json['content']);

		return
		[
			Padding
			(
				padding: EdgeInsets.all(2.0),
				child: create_text(json['content'])
			)
		];
	}
}