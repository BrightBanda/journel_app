import 'package:flutter/material.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: const Text('Journel'),
        backgroundColor: Colors.amber,
      ),
      body: const Center(child: Text('No notes for today!')),
    );
  }
}
