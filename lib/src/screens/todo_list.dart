import 'package:flutter/material.dart';
import 'package:todoflutterapp/src/blocs/todo_bloc.dart';
import 'package:todoflutterapp/src/models/Todo.dart';
import 'package:todoflutterapp/src/models/result.dart';


class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllTodos();
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

//  Widget buildList(AsyncSnapshot<Result> snapshot) {
//    return GridView.builder(
//        itemCount: snapshot.data.todos.length,
//        gridDelegate:
//        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//        itemBuilder: (BuildContext context, int index) {
//          return Text(snapshot.data
//              .todos[index].title);
//        });
//  }

  Widget buildList(AsyncSnapshot<Result> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.todos.length,
        itemBuilder: (BuildContext context, int index) {
          //return Text(snapshot.data.todos[index].title);
          return ListItem();
        });
  }
}
class ListItem extends StatelessWidget {
  final Todo todo;

  ListItem({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: <Widget>[Image.network(
        'https://picsum.photos/250?image=9',
      ),
        new Positioned(
          top: 10.0,
          left: 10.0,
          child: new Container(
              child:Row(children: <Widget>[new Text(todo.toString())],)
          ),
        ),
      ],
    );
  }
}
/*
* Image.network(
            'https://image.tmdb.org/t/p/w185${snapshot.data
                .todos[index].title}',
            fit: BoxFit.cover,
          );*/
