import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Future<List<GroupWidget>> get_group_widgets() async
//{
//	List<GroupWidget> list = new List<GroupWidget>();
//
//	var jsons = await fetch_groups();
//
//	for(var i = 0; i < jsons.length; i++)
//		list.add(GroupWidget(jsons[0]));
//
//	return list;
//}

class GroupWidget extends StatelessWidget
{
	final Map<String, dynamic> json;

	GroupWidget(this.json);

	@override
	Widget build(BuildContext context)
	{
		return Center
		(
			child: Text(json['name']),
		);
	}
}

Future<List<dynamic>> fetch_groups() async
{
	var response = await http.get("https://studyupserver20190527124006.azurewebsites.net/api/groups");

	if (response.statusCode == 200)
		return jsonDecode(response.body);
	else
		throw Exception('Failed to load groups. Error code: ' + response.statusCode.toString() + " " + response.body);
}
//
//Future<List<dynamic>> get_groups() async {
//	values = await get_groups();
//
//	return values;
//}

Widget createListView(BuildContext context, AsyncSnapshot snapshot)
{
	var values = snapshot.data;
	return new ListView.builder
	(
		itemCount: values.length,
		itemBuilder: (BuildContext context, int index)
		{
			return new Column
			(
				children: <Widget>
				[
					new ListTile(title: new Text(values[index]['name']),),
					new Divider(height: 2.0,),
				],
			);
		},
	);
}

group_list_view(var context)
{
	Future<List<dynamic>> future = fetch_groups();

	return FutureBuilder
	(
			future: future,
			builder: (context, snapshot)
			{
				switch(snapshot.connectionState)
				{
					case ConnectionState.none:
						return Text('Error: No connection.');
					case ConnectionState.waiting:
						return CircularProgressIndicator();
					case ConnectionState.done:
						if(snapshot.hasError)
						{
							return Text('Error: ${snapshot.error}');
						}
						else
						{
							return createListView(context, snapshot);
						}
						break;
					case ConnectionState.active:
					// TODO: Handle this case.
						break;
				}
			}
	);
}