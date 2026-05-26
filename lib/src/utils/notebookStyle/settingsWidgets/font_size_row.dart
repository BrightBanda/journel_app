import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journel_new/src/presentation/viewmodel/font_size_notifier.dart';

class FontSizeRow extends ConsumerWidget {
  const FontSizeRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final indicators = [16.0, 20.0, 24.0];
    final selectedAsync = ref.watch(fontSizeProvider);
    final selected = selectedAsync.value ?? 1;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Writing area text size",
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
          Row(
            children: List.generate(indicators.length, (index) {
              final isActive = selected == index;
              return GestureDetector(
                onTap: () =>
                    ref.read(fontSizeProvider.notifier).setIndex(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(left: 6),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isActive
                          ? const Color(0xFFD4A853)
                          : theme.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "A",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: indicators[index],
                        color: isActive
                            ? const Color(0xFFD4A853)
                            : theme.textTheme.bodySmall?.color,
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
  }
}
