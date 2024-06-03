import 'package:homework49_todo/models/todo.dart';

class TodoController {
  final _todoList = [
    TodoModel(title: "Running", date: "12:20", checkDone: false),
    TodoModel(title: "Exercise", date: "Tomorrow", checkDone: false),
    TodoModel(title: "Swimming", date: "4:00", checkDone: false),
  ];

  List<TodoModel> get todoList {
    return [..._todoList];
  }

  void deletePlan(int index) {
    _todoList.removeAt(index);
  }

  void add(String name, String date) {
    _todoList.add(
      TodoModel(title: name, date: date, checkDone: false),
    );
  }

  int counter() {
    int counter = 0;
    for (var i in _todoList) {
      if (i.checkDone != true) {
        counter++;
      }
    }
    return counter;
  }
}