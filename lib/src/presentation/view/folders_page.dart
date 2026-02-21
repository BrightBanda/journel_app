import 'package:flutter/material.dart';

class FoldersPage extends StatelessWidget {
  const FoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: const Text('Journel'),
        backgroundColor: Colors.deepOrange,
      ),
      body: const Center(child: Text('No folders yet!')),
    );
  }
}
