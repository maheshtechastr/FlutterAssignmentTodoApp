class Todo {
  int id;
  int userId;
  String title;
  bool isCompleted;

  Todo(this.id, this.userId, this.title, this.isCompleted);

  Todo.fromjson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    userId = parsedJson['userId'];
    title = parsedJson['title'];
    isCompleted = parsedJson['completed'];
  }
}
