import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArrowRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final bool isDestructive;
  const ArrowRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 15,
                    color: isDestructive
                        ? Colors.redAccent
                        : const Color(0xFFE8DCC8),
                  ),
                ),
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
            Icon(
              Icons.chevron_right,
              color: isDestructive
                  ? Colors.redAccent.withOpacity(0.4)
                  : Colors.grey[700],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
