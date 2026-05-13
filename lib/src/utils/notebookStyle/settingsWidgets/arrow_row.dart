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
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
                        : theme.textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: isDestructive
                  ? Colors.redAccent.withValues(alpha: 0.4)
                  : theme.textTheme.bodySmall?.color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
