import 'package:flutter/material.dart';

class AnotherScreen extends StatefulWidget {
  const AnotherScreen({super.key});

  @override
  State<AnotherScreen> createState() => _AnotherScreenState();
}

class _AnotherScreenState extends State<AnotherScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Another Screen",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 28),
      ),
    );
  }
}