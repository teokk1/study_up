import 'package:flutter/material.dart';
import 'package:study_up/UnJson/UnJsonsBase.dart';
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
	final Function unJsonFunction;

	EntityTabData(this.creator, this.entityController, this.entityId, this.apiEndpoint, this.unJsonFunction);

	void refresh()
	{

	}
}

class EntityTabWithList<T extends Widget> extends EntityTab
{
	EntityTabWithListState<T> state;
	final EntityTabData<T> data;

	EntityTabWithList(creator, header, entityController, entityId, apiEndpoint, unJsonFunction) : data = EntityTabData<T>(creator, entityController, entityId, apiEndpoint, unJsonFunction), super(header);

	@override
	State<StatefulWidget> createState()
	{
		state = EntityTabWithListState<T>(data, fab);
		return state;
	}
	
	void refresh()
	{
		print("Refreshing view");
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
	
	UnJson unJson;

	EntityTabWithListState(this.data, this.fabFunction)
	{
		this.unJson = data.unJsonFunction(context, refresh);
		recreate_list_view();
	}

	recreate_list_view()
	{
		listView = AsyncListView(on_list_item_click, "${data.entityController}/${data.entityId}/${data.apiEndpoint}", unJson);
	}

	void refresh()
	{
		setState(() => recreate_list_view());
	}

	void set_state(Function fn)
	{
		setState(fn);
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
					spacing(10.0),
					listView
				]
			),
			padding: EdgeInsets.all(0.0),
			floatingActionButton: fabFunction(),
			decoration: main_gradient_decoration(),
		);
	}

	@override
	on_list_item_click(context, json, JsonListItemState state)
	{
		if(data.creator(json) != null)
			navigate_to(context, data.creator(json));
	}
}