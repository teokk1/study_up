import 'package:flutter/material.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class FutureWidgets
{
	static FutureBuilder future_text(Future<dynamic> future, [String loadingText = "..."])
	{
		return FutureBuilder
		(
			future: future,
			initialData: loadingText,
			builder: (BuildContext context, AsyncSnapshot<dynamic> text)
			{
				return create_text(text.data.toString(), size: textSizeSmall);
			}
		);
	}

	static FutureBuilder future_button(Future<dynamic> future, Function onClick, [String loadingText = "..."])
	{
		return FutureBuilder
		(
			future: future,
			initialData: loadingText,
			builder: (BuildContext context, AsyncSnapshot<dynamic> text)
			{
				return create_button(text.data.toString(), onClick);
			}
		);
	}
}