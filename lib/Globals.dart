import 'package:flutter/material.dart';

const Color textColorLight = Colors.white;
const Color textColorDark = Colors.black87;

//Color buttonColor = Color(0xFFF26D6D);
//Color accentColor = Color(0xFFDCF2DE);
//Color backgroundColor = Color(0xFF56BF7B);

Color purpleColor = hex_color("#5E5B95");

Color buttonColor = hex_color("#F26D6D");

Color accentColor = hex_color("#DCF2DE");
Color darkerAccentColor = hex_color("#FA5072");

Color backgroundColor = hex_color("#56BF7B");
Color darkBackgroundColor = hex_color("#2A6637");

Color cardBackgroundColor = Color.fromARGB(32, 255, 255, 255);

Color appBarColor = backgroundColor;

Color correctColor = Color.fromARGB(128, 59, 255, 62);
Color wrongColor = Color.fromARGB(128, 209, 27, 61);

Color blueAccentColor = Colors.blue;

const num textSizeSmall = 15.0;
const num textSizeMedium = 20.0;
const num textSizeLarge = 25.0;

const TextStyle textStyle = TextStyle(color: textColorLight, fontSize: textSizeMedium);

const EdgeInsets mainPadding = (const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0));
const EdgeInsets defaultPadding = (const EdgeInsets.fromLTRB(32.0, 64.0, 32.0, 32.0));
const EdgeInsets cardPadding = (const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 32.0));

const String serverUrlBasic = "https://studyupserver20190527124006.azurewebsites.net";
const String serverUrl = serverUrlBasic + "/api/";

RoundedRectangleBorder roundedButtonRect = RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0));

navigate_to(var callerContext, Widget where) => Navigator.push(callerContext, MaterialPageRoute(builder: (callerContext) => where));

Color hex_color(String normalHex)
{
	return Color(int.parse("FF" + normalHex.substring(1, normalHex.length), radix: 16));
}

percentage_width(var context, double percentage)
{
	return percentage * MediaQuery.of(context).size.width;
}

percentage_height(var context, double percentage)
{
	return percentage * MediaQuery.of(context).size.height;
}

Color transparent_white(int alpha)
{
	return Color.fromARGB(alpha, 255, 255, 255);
}