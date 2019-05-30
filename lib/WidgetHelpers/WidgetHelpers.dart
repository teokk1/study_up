import 'package:flutter/material.dart';
import 'package:study_up/HTTP/Auth.dart';

import '../Globals.dart';

create_button(String label, Function onPress)
{
	return RaisedButton(child: create_button_label(label), color: buttonColor, shape: roundedButtonRect, onPressed: onPress,);
}

create_button_label(String content)
{
	return Text(content, style: TextStyle(color: textColorLight, fontSize: textSizeSmall),);
}

create_text(String content, {num size = textSizeMedium, TextAlign alignment = TextAlign.left, Color textColor = textColorLight})
{
	return Text(content, style: TextStyle(color: textColor, fontSize: size));
}

create_dark_text(String content, {num size = textSizeMedium, TextAlign alignment = TextAlign.left})
{
	return create_text(content, size: size, alignment: alignment, textColor: textColorDark);
}

create_divider()
{
	return Divider(height: 8.0, color: Colors.white,);
}

create_snackbar(var context, String message)
{
	Scaffold.of(context).showSnackBar(SnackBar(content: new Text(message)));
}

basic_scaffold(Widget child, {Widget bottomNavigationBar, Widget floatingActionButton, Widget appBar, Widget drawer, EdgeInsets padding = defaultPadding})
{
	return Scaffold
	(
//		backgroundColor: backgroundColor,
		bottomNavigationBar: bottomNavigationBar,
		floatingActionButton: floatingActionButton,

		drawer: drawer,
		appBar: appBar,

		body: Container
		(
			constraints: BoxConstraints.expand(),
			alignment: Alignment.topCenter,
			decoration:	main_gradient_decoration(),
			child: Padding
			(
				padding: padding,
				child: child
			)
		)
	);
}

basic_scaffold_login_required(Widget child, {Widget bottomNavigationBar, Widget floatingActionButton, Widget appBar, Widget drawer})
{
	if(UserManager.user != null)
		return basic_scaffold(child, bottomNavigationBar: bottomNavigationBar, floatingActionButton: floatingActionButton, appBar: appBar, drawer: drawer);

	return basic_scaffold(create_text("Please log in first"));
}

create_fab(IconData icon, Function onPress)
{
	return FloatingActionButton(child: Icon(icon, color: Colors.white), backgroundColor: darkerAccentColor, onPressed: onPress);
}

class LoginLockedScreen extends StatelessWidget
{
	final Widget child;

	LoginLockedScreen(this.child);

	@override
	Widget build(BuildContext context)
	{
		return basic_scaffold_login_required(child);
	}
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

create_card(List<Widget> children, {EdgeInsets padding = cardPadding})
{
	return Card
	(
		elevation: 0,
		color: cardBackgroundColor,
		child: Padding
		(
			padding: padding,
			child: Column
			(
				mainAxisSize: MainAxisSize.min,
				children: children,
			)
		),
	);
}

text_icon(String text, IconData icon, {Color textColor = textColorLight, Color iconColor = Colors.white})
{
	return Row
	(
		children:
		[
			Icon(icon, color: iconColor),
			create_text("  " + text, size: textSizeSmall, textColor: textColor),
		]
	);
}

spacing(var amount)
{
	return SizedBox(height: amount);
}

max_height_box(double maxHeight, BuildContext context, Widget child)
{
	return ConstrainedBox
	(
		constraints: new BoxConstraints( maxHeight: percentage_height(context, maxHeight) ),
		child: child
	);
}

max_width_box(double maxWidth, BuildContext context, Widget child)
{
	return ConstrainedBox
		(
			constraints: new BoxConstraints( maxWidth: percentage_width(context, maxWidth) ),
			child: child
	);
}

max_size_box(double maxWidth, double maxHeight, BuildContext context, Widget child)
{
	return ConstrainedBox
		(
			constraints: new BoxConstraints(maxWidth: percentage_width(context, maxWidth), maxHeight: percentage_height(context, maxHeight)),
			child: child
	);
}

back_button_app_bar(BuildContext context, String title, Widget bottom)
{
	return AppBar
	(
		title: Text(title),
		bottom: bottom,
		backgroundColor: appBarColor,
		leading: IconButton
		(
			icon:Icon(Icons.arrow_back),
			onPressed:() => Navigator.pop(context, false),
		)
	);
}

basic_app_bar()
{
	return AppBar( backgroundColor: appBarColor);
}

create_tabs(List<Widget> widgets)
{
	var returnList = List<Widget>();
	
	for(var widget in widgets)
	{
		returnList.add
		(
			Container
			(
				padding: EdgeInsets.all(8.0),
				child: widget,
			)
		);
	}
	
	return returnList;
}

create_tabs_text(List<String> strings)
{
	var returnList = List<Widget>();

	for(var string in strings)
	{
		returnList.add
		(
			Container
			(
				padding: EdgeInsets.all(8.0),
				child: Text(string),
			)
		);
	}

	return TabBar(tabs: returnList, indicatorColor: darkerAccentColor, labelStyle: TextStyle(color: textColorDark),);
}

create_tab_bar_view(List<Widget> children)
{
	return TabBarView
	(
		children: children,
	);
}

gradient_decoration(List<Color> colors, {List<double> stops = const [0.1, 0.9], Alignment begin = Alignment.topLeft, Alignment end = Alignment.bottomRight})
{
	return BoxDecoration
	(
		gradient: LinearGradient
		(
			begin: begin,
			end: end,

			stops: stops,
			colors: colors,
		),
	);
}

main_gradient_decoration()
{
	return gradient_decoration([hex_color("#36C488"), hex_color("#7BE19A")]);
}

text_field_border(Color borderColor)
{
	return OutlineInputBorder
	(
		borderRadius: BorderRadius.circular(20.0),
		borderSide: BorderSide(color: borderColor),
	);
}

text_field_decoration(String label, Color textColor, Color borderColor)
{
	return InputDecoration
	(
		labelText: label,
		fillColor: Colors.white,
		contentPadding: EdgeInsets.all(12.0),

		labelStyle: TextStyle(color: textColor, fontSize: textSizeSmall),

		enabledBorder: text_field_border(borderColor),
		border:  text_field_border(borderColor),
		focusedBorder: text_field_border(borderColor)
	);
}

text_field(String label, {bool autofocus = false, Function onChanged, Color textColor = textColorLight, Color borderColor = Colors.white, TextEditingController controller, num fontSize = textSizeSmall, textAlign = TextAlign.left,})
{
	return TextField
	(
		controller: controller,
		textAlign: textAlign,
		autofocus: autofocus,
		style: TextStyle(color: textColor, fontSize: fontSize),
		onChanged: onChanged,
		decoration: text_field_decoration(label, textColor, borderColor)
	);
}

dark_text_field(String label, {TextEditingController controller, bool autoFocus = false, textAlign = TextAlign.left, fontSize: textSizeSmall})
{
	return text_field(label, controller: controller, autofocus: autoFocus, textColor: textColorDark, borderColor: Colors.black87, fontSize: fontSize, textAlign: textAlign);
}