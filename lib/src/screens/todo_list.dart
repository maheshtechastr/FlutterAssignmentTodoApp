import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoflutterapp/src/blocs/todo_bloc.dart';
import 'package:todoflutterapp/src/models/Todo.dart';
import 'package:todoflutterapp/src/models/result.dart';

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
        builder: (context, AsyncSnapshot<Result> snapshot) {
          print(snapshot.hasError.toString());
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Column( children: <Widget>[
              Text("Something went wrong"),
              Text("Give it another try"),
              Text("RELOAD"),
            ]);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<Result> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.todos.length,
      itemBuilder: (BuildContext context, int index) {
        //return Text(snapshot.data.todos[index].title);
        return Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            decoration: BoxDecoration(
              //                    <-- BoxDecoration
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
            ),
            child: ListItem(snapshot.data.todos[index]));
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final Todo todo;

  ListItem(this.todo);

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
                      "Status: " + _getString(todo),
                      textScaleFactor: 1.2,
                      textAlign: TextAlign.left,
                    )
                  ])))
    ]);
  }

  String _getString(Todo todo) {
    if (todo.isCompleted)
      return "Completed";
    else
      return "Not Completed";
  }
}
