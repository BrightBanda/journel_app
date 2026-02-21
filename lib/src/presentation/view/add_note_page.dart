import 'package:flutter/material.dart';
import 'package:journel_new/src/utils/customWidgets/folder_btn.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: const Text("Add Note"),
        backgroundColor: const Color.fromARGB(255, 210, 206, 206),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Today's date
            Text(
              "Saturday, February 21, 2026",
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),

            const SizedBox(height: 20),

            // Emoji section
            const Text(
              "How are you feeling?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.emoji_emotions, size: 36, color: Colors.amber),
                Icon(Icons.emoji_emotions, size: 36, color: Colors.amber),
                Icon(Icons.emoji_emotions, size: 36, color: Colors.amber),
                Icon(Icons.emoji_emotions, size: 36, color: Colors.amber),
                Icon(Icons.emoji_emotions, size: 36, color: Colors.amber),
              ],
            ),

            const SizedBox(height: 24),

            // Title text field
            TextField(
              decoration: InputDecoration(
                hintText: 'Give this entry a title...',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Content field
            TextField(
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "What's on your mind today?",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Folders label
            const Text(
              "Save to folder",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 14),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  FolderBtn(title: "Projects"),
                  SizedBox(width: 12),
                  FolderBtn(title: "School"),
                  SizedBox(width: 12),
                  FolderBtn(title: "Work"),
                  SizedBox(width: 12),
                  FolderBtn(title: "Other"),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
