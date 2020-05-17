import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoflutterapp/src/blocs/todo_bloc.dart';
import 'package:todoflutterapp/src/models/todo.dart';
import 'package:todoflutterapp/src/models/result.dart';
import 'package:todoflutterapp/src/utils/util.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllTodos();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          'Todo List',
          style: TextStyle(color: Colors.black),
        )),
      ),
      body: StreamBuilder(
        stream: bloc.allTodos,
        builder: (context, AsyncSnapshot<Result> response) {
          if (response.hasData) {
            return buildList(response);
          } else if (response.hasError) {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                  Text("Something went wrong"),
                  Text("Give it another try"),
                  RaisedButton(
                    color: Colors.white,
                    elevation: 0,
                    child: Text(
                      "RELOAD",
                      style: TextStyle(color: Colors.cyan),
                    ),
                    onPressed: () {
                      print("Reload clicked");
                      bloc.fetchAllTodos();
                    },
                  ),
                ]));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<Result> response) {
    return ListView.builder(
      itemCount: response.data.todos.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
            ),
            child: ListItem(todo: response.data.todos[index]));
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final Todo todo;

  ListItem({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://i.imgur.com/BoN9kdC.png")))),
        ],
      ),
      Flexible(
          child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      todo.title,
                      textScaleFactor: 1.5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Status: " + Util().getString(todo.isCompleted),
                      textScaleFactor: 1.2,
                      textAlign: TextAlign.left,
                    )
                  ])))
    ]);
  }
}
