import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 0),
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.maxFinite,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // emoji and folder row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.emoji_emotions, size: 25, color: Colors.yellow),
                Text("Personal", style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(height: 5),
            //title row
            Text("Project Ideas", style: TextStyle(fontSize: 20)),

            //details row
            SizedBox(height: 5),
            Text(
              "Had a breakthrough idea for the new interface. Had a breakthrough idea for the new interface idea for the new interface",
            ),
          ],
        ),
      ),
    );
  }
}
