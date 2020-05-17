import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:todoflutterapp/src/models/result.dart';

class TodoApiProvider {
  Client client = Client();

  Future<Result> fetchTodoList() async {
    print("entered");
    final response =
        await client.get("http://jsonplaceholder.typicode.com/todos");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Result.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
