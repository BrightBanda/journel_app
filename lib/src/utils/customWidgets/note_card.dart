import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final Text moodIcon;
  final String detals;
  final String folder;
  final String timecreated;

  const NoteCard({
    super.key,
    required this.title,
    required this.moodIcon,
    required this.detals,
    required this.folder,
    required this.timecreated,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 4),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(6),
          border: Border(
            left: BorderSide(
              color: const Color.fromARGB(179, 212, 169, 83),
              width: 2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + mood
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFE8DCC8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  moodIcon,
                ],
              ),

              const SizedBox(height: 12),

              // Content preview
              Text(
                detals,
                style: GoogleFonts.caveat(
                  fontSize: 18,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 10),

              // Folder + time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(168, 83, 24, 0.831),
                      border: Border.all(
                        color: const Color.fromRGBO(168, 83, 68, 0.831),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      folder,
                      style: GoogleFonts.dmSans(
                        fontSize: 10,
                        color: const Color(0xFFD4A853),
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Text(
                    timecreated,
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
