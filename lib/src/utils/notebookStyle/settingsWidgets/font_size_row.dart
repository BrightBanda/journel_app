import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSizeRow extends StatefulWidget {
  const FontSizeRow({super.key});

  @override
  State<FontSizeRow> createState() => _FontSizeRowState();
}

class _FontSizeRowState extends State<FontSizeRow> {
  @override
  Widget build(BuildContext context) {
    final sizes = [16.0, 20.0, 24.0];
    int selectedFontSize = 1;
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
              Text(
                "Font Size",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 15,
                  color: const Color(0xFFE8DCC8),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Writing area text size",
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Row(
            children: List.generate(3, (index) {
              final isActive = selectedFontSize == index;
              return GestureDetector(
                onTap: () => setState(() => selectedFontSize = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(left: 6),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isActive
                          ? const Color(0xFFD4A853)
                          : Colors.grey[800]!,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "A",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: sizes[index],
                        color: isActive
                            ? const Color(0xFFD4A853)
                            : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
    ;
  }
}
