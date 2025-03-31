import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Fish> fishList = [];
  double speed = 1.0;
  Color selectedColor = Colors.blue;

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
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(border: Border.all(), color: Colors.lightBlue[50]),
            child: Stack(children: fishList),
          ),
          Slider(
            min: 0.5,
            max: 3.0,
            value: speed,
            onChanged: (value) => setState(() => speed = value),
          ),
          DropdownButton<Color>(
            value: selectedColor,
            items: [
              DropdownMenuItem(value: Colors.blue, child: Text("Blue")),
              DropdownMenuItem(value: Colors.red, child: Text("Red")),
              DropdownMenuItem(value: Colors.green, child: Text("Green")),
            ],
            onChanged: (color) => setState(() => selectedColor = color!),
          ),
          ElevatedButton(onPressed: _addFish, child: Text("Add Fish")),
        ],
      ),
    );
  }
}
