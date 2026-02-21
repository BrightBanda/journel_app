import 'package:flutter/material.dart';

class FolderBtn extends StatelessWidget {
  final String title;
  const FolderBtn({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: MaterialButton(onPressed: () {}, child: Text(title)),
      ),
    );
  }
}
