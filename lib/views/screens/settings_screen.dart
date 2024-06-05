import 'package:flutter/material.dart';
import 'package:homework49_todo/utils/app_constrants.dart';
import 'package:homework49_todo/views/widgets/custom_drawer.dart';

class SettingsScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onImageChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onImageChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _controller = TextEditingController();
  double _currentSlider = AppConstants.textSize;
  Color pickerColor = Colors.blue; // Initial color for the ColorPicker

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onColorChanged(Color color) {
    setState(() {
      pickerColor = color;
    });
    // Handle the color change if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sozlamalar"),
        actions: [
          IconButton(
            onPressed: () async {
              String imageUrl = _controller.text;
              _controller.clear();
              await AppConstants.setImageUrl(imageUrl);
              widget.onImageChanged(imageUrl);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: CustomDrawer(
        onThemeChanged: widget.onThemeChanged,
        onImageChanged: widget.onImageChanged,
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
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Rasm qo'yish",
                ),
                controller: _controller,
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                activeColor: Colors.green,
                value: AppConstants.themeMode == ThemeMode.dark,
                onChanged: (bool value) async {
                  await AppConstants.setThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light);
                  widget.onThemeChanged(value);
                },
                title: Text(
                  AppConstants.themeMode == ThemeMode.dark
                      ? "Tungi holat"
                      : "Kunduzgi holat",
                  style: TextStyle(fontSize: _currentSlider),
                ),
              ),
              const SizedBox(height: 20),
              Slider(
                min: 14,
                max: 40,
                divisions: 26,
                value: _currentSlider,
                onChanged: (value) async {
                  setState(() {
                    _currentSlider = value;
                  });
                  await AppConstants.setTextSize(value);
                },
                label: _currentSlider.round().toString(),
                activeColor: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Example: Cillum eiusmod mollit est quis.",
                  style: TextStyle(fontSize: _currentSlider),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
