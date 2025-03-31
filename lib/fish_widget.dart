import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Fish extends StatefulWidget {
  final Color color;
  final double speed;

  Fish({required this.color, required this.speed});

  @override
  _FishState createState() => _FishState();
}

class _FishState extends State<Fish> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: (3 ~/ widget.speed)),
      vsync: this,
    )..repeat(reverse: true);

    final random = Random();
    _animation = Tween<Offset>(
      begin: Offset(random.nextDouble(), random.nextDouble()),
      end: Offset(random.nextDouble(), random.nextDouble()),
    ).animate(_controller);

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _animation.value.dx * 250,
      top: _animation.value.dy * 250,
      child: FaIcon(FontAwesomeIcons.fish, color: widget.color, size: 30),
    );
  }
}
