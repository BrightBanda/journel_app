import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journel_new/src/presentation/viewmodel/theme_notifier.dart';
import 'package:journel_new/src/utils/notebookStyle/settingsWidgets/arrow_row.dart';
import 'package:journel_new/src/utils/notebookStyle/settingsWidgets/font_size_row.dart';
import 'package:journel_new/src/utils/notebookStyle/settingsWidgets/section_header.dart';
import 'package:journel_new/src/utils/notebookStyle/settingsWidgets/toggle_row.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProv = ref.watch(ThemeProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        title: Text(
          "Settings",
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFFD4A853),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10, top: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
              ),
              child: Stack(
                children: [
                  // Content
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Security ──
                        SectionHeader(label: "SECURITY"),
                        ToggleRow(
                          title: "PIN Lock",
                          subtitle: "Protect your journal",
                          value: false,
                          onChanged: (value) {},
                        ),
                        ArrowRow(
                          title: "Change PIN",
                          subtitle: "Update your 4-digit PIN",
                          onTap: () {},
                        ),

                        const SizedBox(height: 20),

                        // ── Appearance ──
                        SectionHeader(label: "APPEARANCE"),
                        FontSizeRow(),
                        ToggleRow(
                          title: "Dark Mode",
                          subtitle: "Switch theme",
                          value: themeProv == ThemeMode.dark,
                          onChanged: (val) {
                            ref.read(ThemeProvider.notifier).toggleTheme();
                          },
                        ),

                        const SizedBox(height: 20),

                        // ── Data ──
                        SectionHeader(label: "DATA"),
                        ArrowRow(
                          title: "Export Journal",
                          subtitle: "Save entries as PDF or text",
                          onTap: () {},
                        ),
                        ArrowRow(
                          title: "Clear All Entries",
                          subtitle: "This cannot be undone",
                          onTap: () {},
                          isDestructive: true,
                        ),

                        const SizedBox(height: 32),

                        // Version
                        const Divider(color: Color(0xFF242424)),
                        const SizedBox(height: 12),
                        Center(
                          child: Text(
                            "Journel · v1.0.0",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
