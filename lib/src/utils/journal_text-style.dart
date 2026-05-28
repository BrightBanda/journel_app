import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
// Make sure to import your fontStyleProvider
import 'package:journel_new/src/presentation/viewmodel/font_style_notifier.dart';

extension JournalTextStyles on WidgetRef {
  TextStyle journalTextStyle({
    required double fontSize,
    Color? color,
    double? height,
    FontWeight? fontWeight,
  }) {
    final isCursiveFont = watch(fontStyleProvider);

    if (isCursiveFont) {
      return GoogleFonts.caveat(
        fontSize: fontSize,
        color: color,
        height: height,
        fontWeight: fontWeight,
        letterSpacing: 0.3,
      );
    } else {
      return GoogleFonts.dmSans(
        fontSize: fontSize - 4,
        color: color,
        height: height,
        fontWeight: fontWeight,
      );
    }
  }
}
