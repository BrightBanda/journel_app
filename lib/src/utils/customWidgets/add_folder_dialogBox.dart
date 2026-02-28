import 'package:flutter/material.dart';
import 'package:journel_new/src/data/models/folder.dart';

class AddFolderDialogbox extends StatelessWidget {
  String name = "";
  AddFolderDialogbox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        " Add A New Folder",
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
      content: TextField(
        maxLength: 30,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(labelText: 'folder Name'),
        onChanged: (value) {
          name = value;
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            final folder = Folder(id: DateTime.now().toString(), name: name);
            Navigator.of(context).pop(folder);
          },
          child: Text('ADD'),
        ),
      ],
    );
  }
}
