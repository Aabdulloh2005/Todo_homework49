import 'package:flutter/material.dart';
import 'package:homework49_todo/controllers/notes_controller.dart';
import 'package:homework49_todo/controllers/todo_controller.dart';
import 'package:homework49_todo/utils/app_constrants.dart';
import 'package:homework49_todo/views/widgets/notes_widgets.dart';
import 'package:homework49_todo/views/widgets/plan_widget.dart';

class PlansScreen extends StatefulWidget {
  TodoController todoController;

  PlansScreen({
    required this.todoController,
    super.key,
  });

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  void onDone(int i) {
    widget.todoController.todoList[i].checkDone =
        !widget.todoController.todoList[i].checkDone;
    setState(() {});
  }

  void onDeleted(int i) {
    widget.todoController.deletePlan(i);
    setState(() {});
  }

  void onEdited() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Todos",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              AppConstants.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text(' '));
              },
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: widget.todoController.todoList.length,
            itemBuilder: (context, i) {
              return PlanWidget(
                model: widget.todoController.todoList[i],
                onDone: () => onDone(i),
                onDeleted: () => onDeleted(i),
                onEdited: onEdited,
              );
            },
          ),
        ],
      ),
    );
  }
}

class NotesScreen extends StatefulWidget {
  NotesController notesController;
  NotesScreen({required this.notesController, super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Notes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              AppConstants.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text(' '));
              },
            ),
          ),
          ListView.builder(
            itemCount: widget.notesController.notesList.length,
            itemBuilder: (context, i) {
              final notes = widget.notesController.notesList;
              return NotesWidgets(
                onDeleted: () {
                  setState(() {});
                },
                model: notes[i],
                i: i,
                notesController: widget.notesController,
              );
            },
          ),
        ],
      ),
    );
  }
}
