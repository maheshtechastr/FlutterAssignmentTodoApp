

import 'Todo.dart';

class Result {
  List<Todo> _todos;

  List<Todo> get todos => _todos;

  set todos(List<Todo> value) {
    _todos = value;
  }

  Result.fromJson(List<dynamic> parsedJson) {
    List<Todo> temp = [];
    for (int i = 0; i < parsedJson.length; i++) {
      print("$i ===" + parsedJson[i]["title"]);
      Todo result = Todo.fromjson(parsedJson[i]);
      temp.add(result);
    }
    _todos = temp;
  }
}
