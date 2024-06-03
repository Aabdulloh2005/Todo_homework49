class TodoModel {
  String title;
  String date;
  bool checkDone;

  TodoModel({required this.title, required this.date, required this.checkDone});
}

class NotesModel {
  String title;
  String subtitle;

  NotesModel({
    required this.title,
    required this.subtitle,
  });
}
