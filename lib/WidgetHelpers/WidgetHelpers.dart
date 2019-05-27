import 'package:flutter/material.dart';

import '../Globals.dart';

create_button(String label, Function onPress)
{
	return RaisedButton(child: create_button_label(label), color: buttonColor, shape: roundedButtonRect, onPressed: onPress);
}

create_button_label(String content)
{
	return Text(content, style: TextStyle(color: textColorLight, fontSize: textSizeSmall),);
}

create_text(String content, [num size = textSizeMedium])
{
	return Text(content, style: TextStyle(color: textColorLight, fontSize: size));
}

create_divider()
{
	return Divider(height: 8.0, color: Colors.white,);
}

create_snackbar(var context, String message)
{
	Scaffold.of(context).showSnackBar(SnackBar(content: new Text(message)));
}

basic_scaffold(Widget child)
{
	return Scaffold
	(
		backgroundColor: backgroundColor,
		body: Padding
		(
			padding: mainPadding,
			child: child
		)
	);
}

create_menu(List<Widget> children)
{
	return Align
	(
		alignment: Alignment.topCenter,
		child: Column
		(
			children: children,
		),
	);
}


