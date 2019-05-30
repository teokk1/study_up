import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Globals.dart';
import 'HTTP/Requests.dart';
import 'UnJson/UnJsons.dart';
import 'WidgetHelpers/WidgetHelpers.dart';

abstract class AsyncListViewParent
{
	on_list_item_click(var context, var json, JsonListItemState state) => null;
}

class AsyncListView extends StatelessWidget
{
	final Function onItemClick;
	final String serverEndPoint;
	final UnJson unJson;

	final bool fixedSize;

	AsyncListView(this.onItemClick, this.serverEndPoint, this.unJson, {bool fixedSize = false}) : this.fixedSize = fixedSize;

	create_list_view_fixed(AsyncSnapshot snapshot)
	{
		var values = snapshot.data;
		return ListView.builder
		(
			shrinkWrap: true,
			itemCount: values.length,
			itemBuilder: (BuildContext context, int index)
			{
				return new Column
				(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.start,
					children: <Widget>
					[
						JsonListItem(values[index], onItemClick, unJson),
					],
				);
			},
		);
	}

	create_list_view(AsyncSnapshot snapshot)
	{
		var values = snapshot.data;
		return Flexible
		(
			fit: FlexFit.loose,
			child: ListView.builder
			(
				shrinkWrap: true,
				scrollDirection: Axis.vertical,
				itemCount: values.length,
				itemBuilder: (BuildContext context, int index)
				{
					return new Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>
						[
							JsonListItem(values[index], onItemClick, unJson),
	//						create_divider(),
						],
					);
				},
			)
		);
	}

	Future<List<dynamic>> fetch(String endPoint) async
	{
		print(endPoint);
		var response = await http.get(serverUrl + endPoint);
		return Requests.process_response(endPoint, response);
	}

	widget_for_snapshot(var snapshot, BuildContext context)
	{
		switch(snapshot.connectionState)
		{
			case ConnectionState.none:
				return Text('Error: No connection.');
			case ConnectionState.waiting:
				return CircularProgressIndicator();
			case ConnectionState.done:
				if(snapshot.hasError)
//					return create_text("{$snapshot.error}");
					return create_text(unJson.emptyMessage);
				else
				{
					if(fixedSize)
						return create_list_view_fixed(snapshot);
					else
						return create_list_view(snapshot);
				}
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
				return widget_for_snapshot(snapshot, context);
			}
		);
	}
}

class JsonListItem extends StatefulWidget
{
	final Map<String, dynamic> json;
	final Function onClick;
	final UnJson unJson;

	JsonListItem(this.json, this.onClick, this.unJson);

	@override
	State<StatefulWidget> createState() => JsonListItemState(json, onClick, unJson);
}

class JsonListItemState extends State<JsonListItem>
{
	final Map<String, dynamic> json;
	final Function onClick;
	UnJson unJson;

	JsonListItemState(this.json, this.onClick, this.unJson);

	void update_unjson(UnJson unJson)
	{
		setState(()
		{
			this.unJson = unJson;
		});
	}

	@override
	Widget build(BuildContext context)
	{
		return Container
		(
			child: Material
			(
				child: InkWell
				(
					highlightColor: blueAccentColor,
					splashColor: darkerAccentColor,
					child: FractionallySizedBox
					(
						alignment: Alignment.center,
						widthFactor: unJson.widthFactor,
						child: Container
						(
							child: Column
							(
								crossAxisAlignment: unJson.crossAlignment,
								children: unJson.translate(json),
							),
							alignment: unJson.contentAlignment,
						)
					),
					onTap: () => {onClick(context, json, this)}
				),
				color: Colors.transparent,
			),
			decoration: unJson.decoration,
			margin: unJson.margins,
		);
	}
}