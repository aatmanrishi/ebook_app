import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;

  const AppTabs({Key? key, required this.color, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
      decoration: BoxDecoration(
        color: color, // Remove 'this.'
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center( // Remove 'const'
        child: Text(
          text, // Directly use the text variable'
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}