import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool pinLockEnabled = true;
  bool darkModeEnabled = true;
  int selectedFontSize = 1; // 0 = small, 1 = medium, 2 = large

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        foregroundColor: Colors.white,
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
              decoration: const BoxDecoration(
                color: Color(0xFF1C1C1C),
                borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
              ),
              child: Stack(
                children: [
                  // Red margin line
                  Positioned(
                    left: 48,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 1.5,
                      color: Colors.red.withOpacity(0.12),
                    ),
                  ),

                  // Content
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Security ──
                        _sectionHeader("SECURITY"),
                        _toggleRow(
                          title: "PIN Lock",
                          subtitle: "Protect your journal",
                          value: pinLockEnabled,
                          onChanged: (val) =>
                              setState(() => pinLockEnabled = val),
                        ),
                        _arrowRow(
                          title: "Change PIN",
                          subtitle: "Update your 4-digit PIN",
                          onTap: () {},
                        ),

                        const SizedBox(height: 20),

                        // ── Appearance ──
                        _sectionHeader("APPEARANCE"),
                        _fontSizeRow(),
                        _toggleRow(
                          title: "Dark Mode",
                          subtitle: "Switch theme",
                          value: darkModeEnabled,
                          onChanged: (val) =>
                              setState(() => darkModeEnabled = val),
                        ),

                        const SizedBox(height: 20),

                        // ── Data ──
                        _sectionHeader("DATA"),
                        _arrowRow(
                          title: "Export Journal",
                          subtitle: "Save entries as PDF or text",
                          onTap: () {},
                        ),
                        _arrowRow(
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

  // ── Section header ──
  Widget _sectionHeader(String label) {
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
  }

  // ── Toggle row ──
  Widget _toggleRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
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
                title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 15,
                  color: const Color(0xFFE8DCC8),
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

  // ── Arrow row ──
  Widget _arrowRow({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
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

  // ── Font size row ──
  Widget _fontSizeRow() {
    final sizes = [16.0, 20.0, 24.0];
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
  }
}
