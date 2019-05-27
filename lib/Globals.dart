import 'package:flutter/material.dart';

const Color textColorLight = Colors.white;
const Color textColorDark = Colors.black87;

const Color buttonColor = Colors.lightGreenAccent;
const Color accentColor = Colors.lightGreenAccent;
const Color backgroundColor = Colors.lightGreen;

const num textSizeSmall = 15.0;
const num textSizeMedium = 20.0;
const num textSizeLarge = 25.0;

const TextStyle textStyle = TextStyle(color: textColorLight, fontSize: textSizeMedium);

const EdgeInsets mainPadding = (const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0));
const EdgeInsets defaultPadding = (const EdgeInsets.fromLTRB(32.0, 64.0, 32.0, 32.0));

RoundedRectangleBorder roundedButtonRect = RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0));

create_button(String label, Function onPress)
{
	return RaisedButton(child: create_button_label(label), color: buttonColor, shape: roundedButtonRect, onPressed: onPress);
}

create_button_label(String content)
{
	return Text(content, style: TextStyle(color: textColorDark, fontSize: textSizeSmall),);
}

create_text(String content)
{
	return Text(content, style: textStyle,);
}

create_divider()
{
	return Divider(height: 8.0, color: Colors.white,);
}

navigate_to(var callerContext, Widget where) => Navigator.push(callerContext, MaterialPageRoute(builder: (callerContext) => where));