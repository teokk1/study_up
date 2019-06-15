import 'package:flutter/material.dart';
import 'package:signalr_client/signalr_client.dart';

class SignalR
{
	// The location of the SignalR Server.
	final serverUrl = "https://studyupserver.azurewebsites.net/duels";
//	final serverUrl = "http://10.0.2.2:8080/duels";
	// Creates the connection by using the HubConnectionBuilder.
	HubConnection hubConnection;
	bool connected = false;
	
	String userId;
	String connectionId;
	
	BuildContext context;

	SignalR(this.userId)
	{
		register();
	}
	
	void register() async
	{
		await open_connection();
		
		connectionId = await hubConnection.invoke("RegisterUser", args: <Object>[userId]);
		print("ConnectionId: $connectionId");
	}
	
	Future<void> open_connection() async
	{
		hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
		hubConnection.onclose( (error) => connected = false);
//		hubConnection.on("DuelInvite", handle_duel_invite);
		
		if (hubConnection.state != HubConnectionState.Connected)
		{
			await hubConnection.start();
			print("connected to hub");
			connected = true;
		}
	}
	
	send_duel_request(int duelId, String opponentId) async
	{
		print("Trying to duel $opponentId on duel $duelId");
		var response = await hubConnection.invoke("InitiateDuel", args: <Object>[duelId, userId, opponentId]);
		print(response);
	}
	
	start_duel(String opponentId, int categoryId, int questionCount) async
	{
		return await hubConnection.invoke("StartDuel", args: <Object>[userId, opponentId, categoryId, questionCount]);
	}
	
//	void handle_duel_invite(List<Object> args)
//	{
//		App.snackBarScaffoldKey.currentState.showSnackBar(SnackBar
//		(
//			content: Text(args[0].toString() + " invited you to duel!"), duration: Duration(milliseconds: 5000)),
//		);
//	}

	accept_duel(int duelId, String challengerId)
	{
		print("Accepting duel request");
		print("Acceptor $userId, Challenger: $challengerId");
		return hubConnection.invoke("AcceptDuel", args: <Object>[duelId, userId, challengerId]);
	}
	
	submit_duel(int duelId, int score) async
	{
		var response =  await hubConnection.invoke("SubmitDuel", args: <Object>[duelId, userId, score]);
		print(response);
		return response;
	}
	
}