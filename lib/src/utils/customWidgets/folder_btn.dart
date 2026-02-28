import 'package:flutter/material.dart';

class FolderBtn extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function()? onPressed;
  const FolderBtn({
    super.key,
    required this.title,
    required this.isSelected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: isSelected ? Colors.amberAccent : Colors.grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: MaterialButton(onPressed: onPressed, child: Text(title)),
      ),
    );
  }
}
