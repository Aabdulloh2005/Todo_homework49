import 'package:flutter/material.dart';
import 'package:homework49_todo/utils/app_constrants.dart';
import 'package:homework49_todo/views/screens/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConstants.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void toggleThemeMode(bool value) async {
    final themeMode = value ? ThemeMode.dark : ThemeMode.light;
    await AppConstants.setThemeMode(themeMode);
    setState(() {});
  }

  void changeImage(String image) async {
    if (image.trim().isNotEmpty) {
      await AppConstants.setImageUrl(image);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: AppConstants.themeMode,
      home: ToDoScreen(
        onThemeChanged: toggleThemeMode,
        onImageChanged: changeImage,
      ),
    );
  }
}
