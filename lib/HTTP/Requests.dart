import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Globals.dart';
import 'Auth.dart';

class Requests
{
	static process_response(String route, var response)
	{
		if (response.statusCode == 200)
			return jsonDecode(response.body);
		else if(response.statusCode == 204)
			return null;
		else
			throw Exception('Failed to load at: $route . Error code: ${response.statusCode.toString()}. ${response.body}');
	}

	static Future<List<dynamic>> get_list(String route) async
	{
		var response = await http.get(route);
		return process_response(route, response);
	}

	static Future<Map<String, dynamic>> get_single(String route) async
	{
		var response = await http.get(route);
		return process_response(route, response);
	}

	static school_for_user() async
	{
		var future = await get_single(serverUrl + "users/"+ UserManager.user.id + "/school");

		if(future == null)
			return "No School";

		return future['name'];
	}
}