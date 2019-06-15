import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Globals.dart';
import 'Auth.dart';

class Requests
{
	static process_response(String route, var response, [var emptyResponse = "Empty", var errorInfo = ""])
	{
		if (response.statusCode == 200)
			return jsonDecode(response.body);
		else if(response.statusCode == 204)
			throw Exception(emptyResponse);
		else
			throw Exception('$errorInfo. Failed to load at: $route . Error code: ${response.statusCode.toString()}. ${response.body}');
	}

	static Future<Map<String, dynamic>> post(Map data, String route, {var emptyResponse = "Empty", var errorInfo = ""}) async
	{
		var body = json.encode(data);
		var response = await http.post(route, headers: {"Content-Type": "application/json"}, body: body);

		return process_response(route, response, emptyResponse, errorInfo);
	}
	
	static Future<String> delete(String route, {var emptyResponse = "Empty", var errorInfo = "Delete failed"}) async
	{
		var response = await http.delete(serverUrl + route);
		return "Kinda deleted";
//		return process_response(route, response, emptyResponse, errorInfo);
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

	static check_group_password(var id, var password) async
	{
		var future = await get_single(serverUrl + "groups/${id.toString()}/password/$password");

		if(future == null)
			return false;

		return future;
	}

	static random_question(int categoryId) async
	{
		var future = await get_single(serverUrl + "categories/$categoryId/random-question");

		if(future == null)
			return "No Question";

		return future;
	}
	
	static random_questions(int categoryId, int count) async
	{
		var future = await get_list(serverUrl + "categories/$categoryId/random-questions/$count");
		
		if(future == null)
			return "No Question";
		
		return future;
	}

	static check_answer(int questionId, int answerId) async
	{
		var future = await get_single(serverUrl + "questions/$questionId/check-answer/$answerId");

		if(future == null)
			return "No Question";

		return future;
	}

	Future<Map<String, dynamic>> signin_to_server(var email) async
	{
		Map data =
		{
			"email": email
		};

		return post(data, serverUrl + "users/signin", emptyResponse: "Not logged in", errorInfo: "Failed to sign in to Server.");
	}
}