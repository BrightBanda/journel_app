import 'package:flutter/material.dart';
import 'package:journel_new/src/utils/customWidgets/folder_btn.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(title: Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //today's date
            Text("Saturday, February 21, 2026"),
            SizedBox(height: 16),
            //emoji
            Text("How are you feeling"),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.emoji_emotions, size: 40, color: Colors.yellow),
                Icon(Icons.emoji_emotions, size: 40, color: Colors.yellow),
                Icon(Icons.emoji_emotions, size: 40, color: Colors.yellow),
                Icon(Icons.emoji_emotions, size: 40, color: Colors.yellow),
                Icon(Icons.emoji_emotions, size: 40, color: Colors.yellow),
              ],
            ),
            SizedBox(height: 16),
            //Title text field
            TextField(
              decoration: InputDecoration(
                hintText: 'Give this entry a title...',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontFamily: 'Serif',
                ),
                filled: true,
                fillColor: Color(0xFF2C2C2C), // Dark grey background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none, // Removes the outline
                ),
              ),
            ),

            SizedBox(height: 16), // Space between fields
            // Content Field
            TextField(
              maxLines: 8, // Allows the field to be tall
              decoration: InputDecoration(
                hintText: "What's on your mind today?",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Color(0xFF2C2C2C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 16),
            //folders
            Text("save to folder"),
            SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FolderBtn(title: "Projects"),
                  FolderBtn(title: "School"),
                  FolderBtn(title: "Work"),
                  FolderBtn(title: "Other"),
                ],
              ),
            ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
