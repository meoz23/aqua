import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'fish_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Fish> fishList = [];
  double speed = 1.0;
  Color selectedColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final dbHelper = DatabaseHelper();
    final settings = await dbHelper.loadSettings();
    if (settings != null) {
      setState(() {
        fishList = List.generate(
          settings['fishCount'],
          (_) => Fish(color: selectedColor, speed: speed),
        );
        speed = settings['speed'];
        selectedColor = Color(int.parse(settings['color']));
      });
    }
  }

  void _saveSettings() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.saveSettings(fishList.length, speed, selectedColor.value.toString());
  }

  void _addFish() {
    if (fishList.length < 10) {
      setState(() {
        fishList.add(Fish(color: selectedColor, speed: speed));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Virtual Aquarium")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _saveSettings,
            child: Text("Save Settings"),
          ),

          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(border: Border.all(), color: Colors.lightBlue[50]),
            child: Stack(children: fishList),
          ),

          Text("Speed"),
          Slider(
            min: 0.5,
            max: 3.0,
            value: speed,
            onChanged: (value) => setState(() => speed = value),
          ),

          Text("Select Fish Color"),
          DropdownButton<Color>(
            value: selectedColor,
            items: [
              DropdownMenuItem(value: Colors.blue, child: Text("Blue")),
              DropdownMenuItem(value: Colors.red, child: Text("Red")),
              DropdownMenuItem(value: Colors.green, child: Text("Green")),
            ],
            onChanged: (color) => setState(() => selectedColor = color!),
          ),

          ElevatedButton(
            onPressed: _addFish,
            child: Text("Add Fish"),
          ),
        ],
      ),
    );
  }
}
