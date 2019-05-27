import 'package:flutter/material.dart';
import 'package:study_up/WidgetHelpers/WidgetHelpers.dart';

import '../Globals.dart';

class FutureWidgets
{
	static future_text(Future<dynamic> future, [String loadingText = "..."])
	{
		return new FutureBuilder
			(
				future: future,
				initialData: loadingText,
				builder: (BuildContext context, AsyncSnapshot<dynamic> text)
				{
					return create_text(text.data.toString(), textSizeSmall);
				}
		);
	}
}