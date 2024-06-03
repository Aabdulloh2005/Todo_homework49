import 'package:homework49_todo/models/todo.dart';

class NotesController {
  final List<NotesModel> _notesList = [
    NotesModel(
        title: "Running",
        subtitle:
            "Pariatur labore magna enim dolor non occaecat irure et nulla magna sunt enim."),
    NotesModel(
        title: "Exercise", subtitle: "Laboris et et et et exercitation magna."),
    NotesModel(title: "Swimming", subtitle: "Ut ad ad proident adipisicing."),
  ];

  List<NotesModel> get notesList {
    return [..._notesList];
  }

  void deletePlan(int index) {
    _notesList.removeAt(index);
  }
}
