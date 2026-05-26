import 'package:flutter/material.dart';
import 'package:journel_new/src/data/models/folder.dart';

class AddFolderDialogbox extends StatefulWidget {
  const AddFolderDialogbox({super.key});

  @override
  State<AddFolderDialogbox> createState() => _AddFolderDialogboxState();
}

class _AddFolderDialogboxState extends State<AddFolderDialogbox> {
  String _name = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.cardColor,
      title: Text(
        "Add a new folder",
        style: TextStyle(
          fontSize: 15,
          color: theme.textTheme.bodyLarge?.color,
        ),
      ),
      content: TextField(
        maxLength: 30,
        autofocus: true,
        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          labelText: 'Folder name',
          labelStyle: TextStyle(color: theme.textTheme.bodySmall?.color),
        ),
        onChanged: (value) => _name = value,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            if (_name.trim().isEmpty) return;
            final folder = Folder(
              id: DateTime.now().toString(),
              name: _name.trim(),
            );
            Navigator.of(context).pop(folder);
          },
          child: const Text('ADD'),
        ),
      ],
    );
  }
}
