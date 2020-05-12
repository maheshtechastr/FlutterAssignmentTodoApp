import 'package:flutter/material.dart';

import 'screens/todo_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: TodoList(),
      ),
    );
  }
}
