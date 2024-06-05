import 'package:flutter/material.dart';
import 'package:homework49_todo/controllers/notes_controller.dart';
import 'package:homework49_todo/controllers/todo_controller.dart';
import 'package:homework49_todo/utils/app_constrants.dart';
import 'package:homework49_todo/views/screens/plans_screen.dart';
import 'package:homework49_todo/views/screens/profile_screen.dart';
import 'package:homework49_todo/views/widgets/add_dialog.dart';
import 'package:homework49_todo/views/widgets/custom_drawer.dart';

class ToDoScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onImageChanged;

  const ToDoScreen({
    super.key,
    required this.onThemeChanged,
    required this.onImageChanged,
  });

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  int _selectedIndex = 0;
  TodoController todoController = TodoController();
  NotesController notesController = NotesController();

  List lst = ["Todos", "Notes"];

  @override
  Widget build(BuildContext context) {
    List<Widget> navigators = [
      PlansScreen(todoController: todoController),
      NotesScreen(notesController: notesController),
    ];
    int counter = todoController.counter();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: _selectedIndex == 1
            ? const Text("Home")
            : _selectedIndex == 2
                ? const Text("Statstics")
                : const Text("Profile"),
      ),
      body: Stack(
        fit: StackFit.expand,
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
          [
            // Home Page ===========================================
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(15),
                    itemCount: lst.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => navigators[index]),
                          );
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.01),
                          child: Center(
                            child: Text(
                              lst[index],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // Statistics Page ===========================================
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bajarilgan: ${todoController.todoList.length - counter}",
                    style: TextStyle(
                        fontSize: AppConstants.textSize,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                  Text(
                    "Bajarilmagan: $counter",
                    style: TextStyle(
                      fontSize: AppConstants.textSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Eslatmalar soni: ${notesController.notesList.length}",
                    style: TextStyle(
                      fontSize: AppConstants.textSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            // Profile Page ===========================================
            ProfileScreen(),
          ][_selectedIndex],
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () async {
                Map<String, dynamic>? data = await showDialog(
                  context: context,
                  builder: (context) {
                    return AddDialog();
                  },
                );
                if (data != null) {
                  todoController.add(data["title"], data["date"]);
                }
                setState(() {});
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          _selectedIndex = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.stacked_bar_chart_rounded,
            ),
            label: "Statistics",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          ),
        ],
      ),
      drawer: CustomDrawer(
          onThemeChanged: widget.onThemeChanged,
          onImageChanged: widget.onImageChanged),
    );
  }
}
