import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final void Function(bool)? onChanged;
  const ToggleRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF242424))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.playfairDisplay(fontSize: 15)),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFD4A853),
            activeTrackColor: const Color(0xFFD4A85344),
            inactiveThumbColor: Colors.grey[700],
            inactiveTrackColor: const Color(0xFF2A2A2A),
          ),
        ],
      ),
    );
  }
}
