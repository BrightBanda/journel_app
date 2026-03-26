import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  const SectionHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(width: 12, height: 1, color: const Color(0xFFD4A85388)),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 10,
              color: const Color(0xFFD4A853),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(height: 1, color: const Color(0xFFD4A85322)),
          ),
        ],
      ),
    );
    ;
  }
}
