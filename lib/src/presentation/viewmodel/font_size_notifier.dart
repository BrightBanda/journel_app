import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeNotifier extends AsyncNotifier<int> {
  static const _key = 'font_size_index';
  static const sizes = [18.0, 22.0, 26.0];

  @override
  Future<int> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getInt(_key) ?? 1;
    return stored.clamp(0, sizes.length - 1);
  }

  Future<void> setIndex(int index) async {
    if (index < 0 || index >= sizes.length) return;
    state = AsyncValue.data(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, index);
  }

  static double sizeFor(int index) =>
      sizes[index.clamp(0, sizes.length - 1)];
}

final fontSizeProvider = AsyncNotifierProvider<FontSizeNotifier, int>(
  FontSizeNotifier.new,
);
