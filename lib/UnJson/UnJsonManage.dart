import 'package:flutter/material.dart';
import 'package:study_up/EntityManagament/AddEntityForm.dart';
import 'package:study_up/HTTP/Requests.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';
import 'UnJsonsBase.dart';
import 'UnJsonsComplex.dart';

abstract class UnJsonManageBase extends UnJsonSinglePadded
{
	String controller;
	Function refreshFunction;
	BuildContext context;
		
	UnJsonManageBase
	(
		this.context, String key, this.controller, this.refreshFunction,
		{
			IconData icon = Icons.group, double paddingSize = 20.0, double iconSize = 50.0, num textSize = textSizeMedium,
			TextAlign textAlignment = TextAlign.start, MainAxisAlignment mainAlign = MainAxisAlignment.spaceBetween
		}
	)
	: super(key, icon: icon, paddingSize: paddingSize, iconSize: iconSize, textSize: textSize, textAlignment: textAlignment, mainAlign: mainAlign);
	
	List<Widget> create_children(Map<String, dynamic> json)
	{
		return
		[
			Icon(icon, color: Colors.white, size: iconSize),
			SizedBox(width: 20.0),
			Expanded
			(
				child: Wrap
				(
					children:
					[
						create_text(json[key], alignment: textAlignment, size: textSize)
					]
				)
			),
			IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
			IconButton(onPressed: () => delete(json['id']), icon: Icon(Icons.delete)),
		];
	}
	
	void delete(var id) async
	{
		are_you_sure(id);
	}
	
	void are_you_sure(var id)
	{
		showDialog
		(
			context: context,
			
			builder: (BuildContext context)
			{
				return AlertDialog
				(
					backgroundColor: accentColor,
					title: create_dark_text("Jeste li sigurni?"),
					content: create_dark_text("Brisanje je nepovratna akcija!", alignment: TextAlign.center),
					actions: <Widget>
					[
						FlatButton(child: create_dark_text("Ipak ne"), onPressed: () => cancel_delete(context)),
						FlatButton(child: create_dark_text("Izbriši!"), onPressed: () => confirm_delete(context, id)),
					],
				);
			}
		);
	}
	
	Future confirm_delete(BuildContext context, var id) async
	{
		Navigator.pop(context);
		var response = await Requests.delete("$controller/$id");
		print(response);
		refreshFunction();
	}
	
	void cancel_delete(BuildContext context)
	{
		Navigator.pop(context);
	}
}

abstract class UnJsonManageUneditableBase extends UnJsonSinglePadded
{
	String controller;
	Function refreshFunction;
	BuildContext context;
	
	String removeTitle;
	String removeRoute;
	
	UnJsonManageUneditableBase
	(
		this.context, this.removeTitle, this.removeRoute, String key, this.controller, this.refreshFunction,
		{
			IconData icon = Icons.group, double paddingSize = 20.0, double iconSize = 50.0, num textSize = textSizeMedium,
			TextAlign textAlignment = TextAlign.start, MainAxisAlignment mainAlign = MainAxisAlignment.spaceBetween
		}
	)
	: super(key, icon: icon, paddingSize: paddingSize, iconSize: iconSize, textSize: textSize, textAlignment: textAlignment, mainAlign: mainAlign);
	
	List<Widget> create_children(Map<String, dynamic> json)
	{
		return
		[
				Icon(icon, color: Colors.white, size: iconSize),
				SizedBox(width: 20.0),
				Expanded
				(
					child: Wrap
					(
						children:
						[
							create_text(json[key], alignment: textAlignment, size: textSize)
						]
					)
				),
				IconButton(onPressed: () => delete(json['id']), icon: Icon(Icons.delete)),
			];
	}
	
	void delete(var id) async
	{
		are_you_sure(id);
	}
	
	void are_you_sure(var id)
	{
		showDialog
		(
			context: context,
			
			builder: (BuildContext context)
			{
				return AlertDialog
				(
					backgroundColor: accentColor,
					title: create_dark_text(removeTitle),
					content: create_dark_text("Ovo je nepovratna akcija!", alignment: TextAlign.center),
					actions: <Widget>
					[
						FlatButton(child: create_dark_text("Ipak ne"), onPressed: () => cancel_delete(context)),
						FlatButton(child: create_dark_text("Nastavi!"), onPressed: () => confirm_delete(context, id)),
					],
				);
			}
		);
	}
	
	Future confirm_delete(BuildContext context, var id) async
	{
		Navigator.pop(context);
		var response = await Requests.get_single("$removeRoute/$id");
		print(response);
		refreshFunction();
	}
	
	void cancel_delete(BuildContext context)
	{
		Navigator.pop(context);
	}
}

class UnJsonGroupManage extends UnJsonManageBase
{
	UnJsonGroupManage(BuildContext context, Function refreshFunction, {IconData icon = Icons.group, double paddingSize = 20.0, double iconSize = 50.0}) : super(context, "name", "groups", refreshFunction, icon: icon, paddingSize: paddingSize, iconSize: iconSize)
	{
		emptyMessage = "Nema grupa";
	}
}

class UnJsonSubjectManage extends UnJsonManageBase
{
	UnJsonSubjectManage(BuildContext context, Function refreshFunction, {IconData icon = Icons.lightbulb_outline, double paddingSize = 18.0, double iconSize = 50.0}) : super(context, "name", "subjects", refreshFunction, icon: icon, paddingSize: paddingSize, iconSize: iconSize)
	{
		emptyMessage = "Nema predmeta";
	}
}

class UnJsonCategoryManage extends UnJsonManageBase
{
	UnJsonCategoryManage(BuildContext context, Function refreshFunction, {IconData icon = Icons.category, double paddingSize = 18.0, double iconSize = 50.0}) : super(context, "name", "categories", refreshFunction, icon: icon, paddingSize: paddingSize, iconSize: iconSize)
	{
		emptyMessage = "Nema kategorija";
	}
}

class UnJsonMemberManage extends UnJsonManageUneditableBase
{
	UnJsonMemberManage(BuildContext context, Function refreshFunction, {IconData icon = Icons.person, double paddingSize = 8.0, double iconSize = 30.0})
		: super(context, "Jeste li sigurni da želite izbaciti člana?", "", "userName", "users", refreshFunction, icon: icon, paddingSize: paddingSize, iconSize: iconSize)
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

class UnJsonLeaderboardManage extends UnJsonManageBase
{
	UnJsonLeaderboardManage(BuildContext context, Function refreshFunction, {IconData icon = Icons.stars, double paddingSize = 8.0, double iconSize = 30.0}) : super(context, "userName", "users", refreshFunction, icon: icon, paddingSize: paddingSize, iconSize: iconSize)
	{
		emptyMessage = "Nema ljestvica";
	}
}

class UnJsonQuestionManage extends UnJson implements AsyncListViewParent
{
	UnJson unJsonAnswer;
	UnJsonQuestionManage(this.unJsonAnswer)
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

class UnJsonAnswerManage extends UnJsonAnswerSmall
{
	TextFieldWithController textField;
	
	UnJsonAnswerManage()
	{
		widthFactor = 1;
		contentAlignment = Alignment.center;
		decoration = gradient_decoration([transparent_white(32), transparent_white(64)]);
	}
}