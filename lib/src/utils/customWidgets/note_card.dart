import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final Icon moodIcon;
  final String detals;
  final String folder;
  const NoteCard({
    super.key,
    required this.title,
    required this.moodIcon,
    required this.detals,
    required this.folder,
  });

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
                moodIcon,
                Text(folder, style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(height: 5),
            //title row
            Text(title, style: TextStyle(fontSize: 20)),

            //details row
            SizedBox(height: 5),
            Text(detals),
          ],
        ),
      ),
    );
  }
}
