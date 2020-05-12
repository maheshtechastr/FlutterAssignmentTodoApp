import 'dart:async';

import 'package:todoflutterapp/src/models/result.dart';

import 'TodoApiProvider.dart';

class Repository {
  final todoApiProvider = TodoApiProvider();

  Future<Result> fetchAllTodo() => todoApiProvider.fetchTodoList();
}