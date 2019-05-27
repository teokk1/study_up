import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Globals.dart';

class AsyncListView extends StatelessWidget
{
	final Function onItemClick;
	final String serverEndPoint;
	final UnJson unJson;

	AsyncListView(this.onItemClick, this.serverEndPoint, this.unJson);

	create_list_view(AsyncSnapshot snapshot)
	{
		var values = snapshot.data;
		return new ListView.builder
		(
			itemCount: values.length,
			itemBuilder: (BuildContext context, int index)
			{
				return new Column
				(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>
					[
						JsonListWidget(values[index], onItemClick, unJson),
						create_divider(),
					],
				);
			},
		);
	}

	Future<List<dynamic>> fetch(String endPoint) async
	{
		var response = await http.get("https://studyupserver20190527124006.azurewebsites.net/api/" + endPoint);

		if (response.statusCode == 200)
			return jsonDecode(response.body);
		else
			throw Exception('Failed to load groups. Error code: ' + response.statusCode.toString() + " " + response.body);
	}

	widget_for_snapshot(var snapshot)
	{
		switch(snapshot.connectionState)
		{
			case ConnectionState.none:
				return Text('Error: No connection.');
			case ConnectionState.waiting:
				return CircularProgressIndicator();
			case ConnectionState.done:
				if(snapshot.hasError)
					return Text('Error: ${snapshot.error}');
				else
					return create_list_view(snapshot);
				break;
			case ConnectionState.active:
				// TODO: Handle this case.
				break;
		}
	}

	@override
	Widget build(BuildContext context)
	{
		return FutureBuilder
		(
			future: fetch(serverEndPoint),
			builder: (context, snapshot)
			{
				return widget_for_snapshot(snapshot);
			}
		);
	}
}

class JsonListWidget extends StatelessWidget
{
	final Map<String, dynamic> json;
	final Function onClick;
	final UnJson unJson;

	JsonListWidget(this.json, this.onClick, this.unJson);

	@override
	Widget build(BuildContext context)
	{
		return InkWell
		(
			child: Container
			(
				child: Column
				(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: unJson.translate(json),
				),
				alignment: Alignment.centerLeft,
			),
			onTap: () => {onClick(context, json)}
		);
	}
}

class UnJson
{
	List<Widget> translate(Map<String, dynamic> json)
	{
		return [Text("Override UnJson for your class")];
	}
}