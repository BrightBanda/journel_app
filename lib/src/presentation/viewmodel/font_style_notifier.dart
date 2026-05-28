import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontStyleNotifier extends StateNotifier<bool> {
  FontStyleNotifier() : super(false) {
    _loadFromPrefs();
  }

  // Key for local storage persistence
  static const _key = 'is_cursive_font';

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_key) ?? false; // default to false (standard font)
  }

  Future<void> toggleFont() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, state);
  }
}

// Global provider instance
final fontStyleProvider = StateNotifierProvider<FontStyleNotifier, bool>((ref) {
  return FontStyleNotifier();
});
