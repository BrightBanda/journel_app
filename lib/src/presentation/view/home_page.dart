import 'package:flutter/material.dart';
import 'package:journel_new/src/utils/customWidgets/note_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Journel',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(width: 40),
            Text(
              'saturday, february 21, 2026',
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 176, 176, 176),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 0, 137, 250),
      ),
      body: ListView(children: [NoteCard(), NoteCard()]),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
