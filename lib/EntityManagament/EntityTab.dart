import 'package:flutter/material.dart';
import 'package:study_up/UnJson/UnJsons.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../AsyncList.dart';
import '../Globals.dart';

typedef S ItemCreator<S>(Map<String, dynamic> json);

abstract class EntityTab extends StatefulWidget
{
	final String header;
	EntityTab(this.header);
}

class EntityTabData<T extends Widget>
{
	final ItemCreator<T> creator;

	final String entityController;
	final int entityId;

	final String apiEndpoint;
	final UnJson unJson;

	EntityTabData(this.creator, this.entityController, this.entityId, this.apiEndpoint, this.unJson);

	void refresh()
	{

	}
}

class EntityTabWithList<T extends Widget> extends EntityTab
{
	EntityTabWithListState<T> state;
	final EntityTabData<T> data;

	EntityTabWithList(creator, header, entityController, entityId, apiEndpoint, unJson) : data = EntityTabData<T>(creator, entityController, entityId, apiEndpoint, unJson), super(header);

	@override
	State<StatefulWidget> createState()
	{
		state = EntityTabWithListState<T>(data, fab);
		return state;
	}

	void refresh()
	{
		state.refresh();
	}

	fab()
	{

	}
}

class EntityTabWithListState<T extends Widget> extends State<EntityTabWithList<T>> implements AsyncListViewParent
{
	EntityTabData data;
	Function fabFunction;

	AsyncListView listView;

	EntityTabWithListState(this.data, this.fabFunction)
	{
		recreate_list_view();
	}

	recreate_list_view()
	{
		listView = AsyncListView(on_list_item_click, "${data.entityController}/${data.entityId}/${data.apiEndpoint}", data.unJson);
	}

	void refresh()
	{
		setState(() => recreate_list_view());
	}

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold
		(
			Column
			(
				mainAxisSize: MainAxisSize.max,
				children: <Widget>
				[
					listView
				]
			),
			padding: EdgeInsets.all(0.0),
			floatingActionButton: fabFunction()
		);
	}

	@override
	on_list_item_click(context, json, JsonListItemState state)
	{
		if(data.creator(json) != null)
			navigate_to(context, data.creator(json));
	}
}