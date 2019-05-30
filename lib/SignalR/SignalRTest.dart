import 'package:logging/logging.dart';
import 'package:signalr_client/signalr_client.dart';

class SignalRTest
{
	// The location of the SignalR Server.
	final serverUrl = "https://studyupserver20190527124006.azurewebsites.net";
	// Creates the connection by using the HubConnectionBuilder.
	var hubConnection;

	Logger logger = Logger("SignalR");

	SignalRTest()
	{
		hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
		hubConnection.onclose( (error) => print("Connection Closed"));

		hubConnection.on("ReceiveMessage", handleAClientProvidedFunction);
	}

	void handleAClientProvidedFunction(List<Object> parameters)
	{
		print(parameters[0]);
	}

	test_connection() async
	{
		final result = await hubConnection.invoke("MethodOneSimpleParameterSimpleReturnValue", args: <Object>["ParameterValue"]);

		print("$result");

		await hubConnection.invoke("send_message", args: <Object>["hoh", "heh"]);

		return result;
	}
}
