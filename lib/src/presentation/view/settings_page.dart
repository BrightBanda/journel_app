import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journel_new/src/presentation/view/pin_lock_page.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/pin_notifier.dart';
import 'package:journel_new/src/presentation/viewmodel/theme_notifier.dart';
import 'package:journel_new/src/utils/notebookStyle/settingsWidgets/arrow_row.dart';
import 'package:journel_new/src/utils/notebookStyle/settingsWidgets/font_size_row.dart';
import 'package:journel_new/src/utils/notebookStyle/settingsWidgets/section_header.dart';
import 'package:journel_new/src/utils/notebookStyle/settingsWidgets/toggle_row.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  Future<void> _togglePinLock(
    BuildContext context,
    WidgetRef ref,
    bool value,
  ) async {
    final pinNotifier = ref.read(pinProvider.notifier);
    final pinState = ref.read(pinProvider).value;
    if (pinState == null) return;

    if (value) {
      if (!pinState.hasPin) {
        final pinToUse = await setPinDialog(context, ref);
        if (pinToUse == null) return;
        // Internal persistence occurs safely within createNewPin viewmodel block
      }
      await pinNotifier.enableLock();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN Lock enabled'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      final ok = await verifyPinDialog(context, ref);
      if (!ok) return;
      await pinNotifier.disableLock();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN Lock disabled'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _changePin(BuildContext context, WidgetRef ref) async {
    final pinState = ref.read(pinProvider).value;
    if (pinState == null) return;

    if (pinState.hasPin) {
      final ok = await verifyPinDialog(context, ref);
      if (!ok) return;
    }

    if (!context.mounted) return;

    // Setting up the new pin implicitly writes it to persistent storage now!
    final newPin = await setPinDialog(context, ref);
    if (newPin == null) return;

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PIN updated'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // ... rest of your code (_clearAllEntries and build implementation) stays completely unchanged

  Future<void> _clearAllEntries(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return AlertDialog(
          backgroundColor: theme.cardColor,
          title: Text(
            'Clear all entries?',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          content: Text(
            'This permanently deletes every journal entry. This action cannot be undone.',
            style: GoogleFonts.dmSans(
              fontSize: 13,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text(
                'Delete all',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
    if (confirmed != true) return;
    await ref.read(noteProvider.notifier).clearAll();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All entries deleted'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProv = ref.watch(ThemeProvider);
    final pinAsync = ref.watch(pinProvider);
    final pinState = pinAsync.value;
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
                          value: pinState?.lockEnabled ?? false,
                          onChanged: pinState == null
                              ? null
                              : (value) => _togglePinLock(context, ref, value),
                        ),
                        ArrowRow(
                          title: "Change PIN",
                          subtitle: pinState?.hasPin == true
                              ? "Update your 4-digit PIN"
                              : "Set a 4-digit PIN",
                          onTap: () => _changePin(context, ref),
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
                          title: "Clear All Entries",
                          subtitle: "This cannot be undone",
                          onTap: () => _clearAllEntries(context, ref),
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
