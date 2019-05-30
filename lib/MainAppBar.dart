import 'package:flutter/material.dart';
//
//back_button_app_bar(BuildContext context, String title, Widget bottom)
//{
//	return AppBar
//		(
//			title: Text(title),
//			bottom: bottom,
//			backgroundColor: appBarColor,
//			leading: IconButton
//			(
//				icon:Icon(Icons.arrow_back),
//				onPressed:() => Navigator.pop(context, false),
//			)
//	);
//}

class MainBarButton extends StatelessWidget
{
	Icon icon;
	Function onPress;

	MainBarButton(this.icon, this.onPress);

	@override
	Widget build(BuildContext context)
	{
		return IconButton(icon: icon, onPressed: onPress);
	}
}

class MainBarMenuButton extends StatelessWidget
{
	final List<PopupMenuButton> buttons;

//	create_item()
//	{
//		return PopupMenuItem(onSelected: (), child: Text(""));
//	}

	MainBarMenuButton(this.buttons);

	@override
	Widget build(BuildContext context)
	{
		return PopupMenuButton
		(
			itemBuilder: (BuildContext context)
			{
				return List<PopupMenuItem>();
			},
		);
	}
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget
{
	final List<MainBarButton> buttons;

	MainAppBar(this.buttons);

	@override
	Widget build(BuildContext context)
	{
		return AppBar
		(
			title: const Text('Basic AppBar'),
			actions: buttons,
		);
	}

	@override
	Size get preferredSize => Size(200, 50);
}