import 'package:flutter/material.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

class UnJson
{
	List<Widget> translate(Map<String, dynamic> json)
	{
		return [Text("Override UnJson for your class")];
	}
}

class UnJsonGroup extends UnJson
{
	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			create_text(json['name']),
		];
	}
}

class UnJsonSubject extends UnJson
{
	@override List<Widget> translate(Map<String, dynamic> json)
	{
		return
		[
			create_text(json['name']),
		];
	}
}