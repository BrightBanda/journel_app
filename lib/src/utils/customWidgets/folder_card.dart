import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FolderCard extends StatelessWidget {
  final String name;
  final Future<void> Function(BuildContext)? onPressed;
  const FolderCard({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4, right: 4),
      child: Slidable(
        endActionPane: ActionPane(
          motion: BehindMotion(),
          children: [
            SlidableAction(
              onPressed: onPressed,
              icon: Icons.delete,
              label: "delete",
              backgroundColor: Colors.redAccent,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emoji + folder row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // mood
                  Text(
                    "updated 2 days ago",
                    style: TextStyle(fontSize: 13, color: Colors.grey[400]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      //number of entries
                      "2 :Entries",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Title
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Details
              Text(
                "Feb 28: making a new game",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Sept 12: downloading anime",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
