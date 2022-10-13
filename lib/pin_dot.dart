import 'package:flutter/material.dart';

class PinDot extends StatelessWidget {
  final int position;
  final String currentPin;

  const PinDot({Key? key, required this.position, required this.currentPin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPositionFilled = currentPin.length >= position;
    MaterialColor color = isPositionFilled ? Colors.blue : Colors.grey;
    return Container(
      width: 16,
      height: 16,
      margin: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle
      ),
    );
  }
}