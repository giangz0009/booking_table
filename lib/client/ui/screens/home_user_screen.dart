import 'package:flutter/material.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome to Home Main Screen 🎉",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
