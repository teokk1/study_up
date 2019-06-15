import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/AddEntityForm.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';
import 'UnJsonsBase.dart';

class UnJsonGroupJoin extends UnJsonSinglePadded
{
	UnJsonGroupJoin() : super('name', )
	{
		emptyMessage = "Nema grupa";
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

class UnJsonGroupExtended extends UnJsonSinglePadded
{
	UnJsonGroupExtended({Color color1, Color color2, IconData icon = Icons.group, double paddingSize = 20.0, double iconSize = 50.0})
		: super("name", icon: icon, paddingSize: paddingSize, iconSize: iconSize, color1: color1, color2: color2)
	{
		emptyMessage = "Nema grupa";
	}
	
	List<Widget> create_children(Map<String, dynamic>  json)
	{
		return
		[
			Icon(icon, color: Colors.white, size: iconSize),
			SizedBox(width: 10.0),
			Expanded
			(
				child: Wrap
				(
					children:
					[
						create_text(json[key], alignment: textAlignment, size: textSize),
					]
				)
			),
//			create_button("Postani Admin", (){}, scale: 0.5),
		];
	}
}

class UnJsonSubject extends UnJsonSinglePadded
{
	UnJsonSubject({Color color1, Color color2, IconData icon = Icons.lightbulb_outline, double paddingSize = 18.0, double iconSize = 50.0})
		: super("name", icon: icon, paddingSize: paddingSize, iconSize: iconSize, color1: color1, color2: color2)
	{
		emptyMessage = "Nema predmeta";
	}
}

class UnJsonCategory extends UnJsonSinglePadded
{
	UnJsonCategory({Color color1, Color color2, IconData icon = Icons.category, double paddingSize = 18.0, double iconSize = 50.0})
		: super("name", icon: icon, paddingSize: paddingSize, iconSize: iconSize, color1: color1, color2: color2)
	{
		emptyMessage = "Nema kategorija";
	}
}

class UnJsonMember extends UnJsonSinglePadded
{
	UnJsonMember({IconData icon = Icons.person, double paddingSize = 8.0, double iconSize = 30.0}) : super("userName", icon: icon, paddingSize: paddingSize, iconSize: iconSize)
	{
		emptyMessage = "Nema članova";
	}
	
	@override
	List<Widget> create_children(Map<String, dynamic>  json)
	{
		List<Widget> children =
		[
			create_text(json[key], alignment: textAlignment),
		];
		
		if(json['isAdmin'] != null && json['isAdmin'])
			children.add(Icon(Icons.person_pin, color: Colors.white, size: iconSize));
		
		children.add(Icon(icon, color: Colors.white, size: iconSize));
		
		return children;
	}
}

class UnJsonMemberAdmin extends UnJsonSinglePadded
{
	UnJsonMemberAdmin({IconData icon = Icons.person, double paddingSize = 8.0, double iconSize = 30.0}) : super("userName", icon: icon, paddingSize: paddingSize, iconSize: iconSize)
	{
		emptyMessage = "Nema članova";
	}
	
	@override
	List<Widget> create_children(Map<String, dynamic>  json)
	{
		List<Widget> children =
		[
			create_text(json[key], alignment: textAlignment),
		];
		
		print(json);
		
		if(json['isAdmin'] != null && json['isAdmin'])
			children.add(Icon(Icons.person_pin, color: Colors.white, size: iconSize));
		
//		children.add(Icon(icon, color: Colors.white, size: iconSize));
		
		return children;
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

class UnJsonAnswerSmall extends UnJsonSinglePadded
{
	TextFieldWithController textField;

	UnJsonAnswerSmall(): super("content", paddingSize: 4.0, textAlignment: TextAlign.center, iconSize: 0, mainAlign: MainAxisAlignment.center)
	{
		emptyMessage = "Error Getting Answer";

		widthFactor = 1;
		margins = EdgeInsets.only(top: 2.0);
		crossAlignment = CrossAxisAlignment.center;
		contentAlignment = Alignment.center;
		decoration = gradient_decoration([transparent_white(16), transparent_white(16)]);
	}
}

class UnJsonAnswerView extends UnJsonAnswerSmall
{
	TextFieldWithController textField;

	UnJsonAnswerManage()
	{
		widthFactor = 1;
		contentAlignment = Alignment.center;
		decoration = gradient_decoration([transparent_white(32), transparent_white(64)]);
	}
}

class UnJsonTestView extends UnJsonSinglePadded
{
	UnJsonTestView({icon: Icons.play_circle_outline}) : super("name", icon: icon)
	{
		emptyMessage = "Nema testova!";
	}

	@override
	on_list_item_click(context, json, JsonListItemState state)
	{

	}

	@override
	List<Widget> create_children(Map<String, dynamic>  json)
	{
		return
		[
			create_text(json[key], alignment: textAlignment),
			Icon(icon, color: Colors.white, size: iconSize),
		];
	}
}

class UnJsonTestManage extends UnJsonTestView
{
	UnJsonTestManage() : super(icon: Icons.assignment);
}

class UnJsonTestTake extends UnJsonTestView
{
	UnJsonTestTake() : super(icon: Icons.assignment);

	void take_test()
	{

	}
}

class UnJsonTestResult extends UnJsonSinglePadded
{
	UnJsonTestResult() : super("name", icon: Icons.date_range);
	
	@override
	List<Widget> create_children(Map<String, dynamic>  json)
	{
		return
		[
			create_text(json[key], alignment: textAlignment),
			create_text("Rezultat", alignment: textAlignment),
			create_text(json['result'], alignment: textAlignment),
			create_text("Maksimalno bodova", alignment: textAlignment),
			create_text(json['total'], alignment: textAlignment),
			Icon(icon, color: Colors.white, size: iconSize),
		];
	}
}

class UnJsonDuel extends UnJsonSinglePadded
{
	UnJsonDuel() : super("player1", icon: Icons.compare_arrows)
	{
		emptyMessage = "Nema dvoboja";
	}
	
	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			Container
			(
				padding: EdgeInsets.all(20.0),
				margin: EdgeInsets.only(bottom: 10.0),
				child: Column
				(
					mainAxisSize: MainAxisSize.min,
					children:
					[
//						Icon(icon, color: Colors.white, size: iconSize),
//						spacing(10.0),
						Column(children: create_children(json)),
//						spacing(10.0),
					]
				)
			)
		];
	}
	
	create_row(List<Widget> children)
	{
		return Row
		(
			mainAxisAlignment: MainAxisAlignment.center,
			children: children
		);
	}
	
	to_string_null(String str, String alt)
	{
		return str == null ? alt : str;
	}
	
	@override
	List<Widget> create_children(Map<String, dynamic>  json)
	{
		return
		[
			Column
			(
				mainAxisSize: MainAxisSize.max,
				children:
				[
					create_row
					([
						create_text("${json["questionCount"]} pitanja", alignment: textAlignment),
					]),
					create_row
					([
						create_text(to_string_null(json['category'], "Nema kategorije"), alignment: textAlignment),
					]),
					spacing(10.0),
					create_row
					([
						create_text(json['player1'], alignment: textAlignment),
						create_text(" VS "),
						create_text(json['player2'], alignment: textAlignment),
					]),
					create_row
					([
						create_text(to_string_null(json['player1Score'], ""), alignment: textAlignment),
						create_text(" : "),
						create_text(to_string_null(json['player2Score'], "") , alignment: textAlignment),
					]),
				]
			)
		];
	}
}

class UnJsonDuelResult extends UnJson
{

}

class UnJsonFriend extends UnJsonSinglePadded
{
	UnJsonFriend() : super("userName", icon: Icons.person)
	{
		emptyMessage = "Nemate prijatelja :(";
	}
	
	@override
	List<Widget> create_children(Map<String, dynamic>  json)
	{
		return
		[
			create_text(json[key], alignment: textAlignment),
			Icon(icon, color: Colors.white, size: iconSize),
		];
	}
}