import 'dart:async';

import 'package:todoflutterapp/src/models/result.dart';

import 'todo_api_provider.dart';

class Repository {
  final todoApiProvider = TodoApiProvider();

  Future<Result> fetchAllTodo() => todoApiProvider.fetchTodoList();
}