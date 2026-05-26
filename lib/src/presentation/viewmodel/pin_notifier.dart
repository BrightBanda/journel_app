import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinState {
  final bool lockEnabled;
  final bool unlocked;
  final bool hasPin;

  const PinState({
    required this.lockEnabled,
    required this.unlocked,
    required this.hasPin,
  });

  PinState copyWith({bool? lockEnabled, bool? unlocked, bool? hasPin}) =>
      PinState(
        lockEnabled: lockEnabled ?? this.lockEnabled,
        unlocked: unlocked ?? this.unlocked,
        hasPin: hasPin ?? this.hasPin,
      );

  bool get requiresGate => lockEnabled && hasPin && !unlocked;
}

class PinNotifier extends AsyncNotifier<PinState> {
  static const _pinKey = 'app_pin';
  static const _lockKey = 'pin_lock_enabled';
  final _storage = const FlutterSecureStorage();

  @override
  Future<PinState> build() async {
    final pin = await _storage.read(key: _pinKey);
    final lock = await _storage.read(key: _lockKey);
    final lockEnabled = lock == 'true' && pin != null;
    return PinState(
      lockEnabled: lockEnabled,
      unlocked: !lockEnabled,
      hasPin: pin != null,
    );
  }

  // Add this helper method inside your existing PinNotifier class:
  Future<String?> getStoredPinDirectly() async {
    return await _storage.read(key: _pinKey);
  }

  // Modify your verify method slightly to be robust:
  Future<bool> verify(String pin) async {
    final stored = await _storage.read(key: _pinKey);
    if (stored != null && stored == pin) {
      state = AsyncValue.data(state.value!.copyWith(unlocked: true));
      return true;
    }
    return false;
  }

  Future<void> setPin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
    state = AsyncValue.data(
      state.value!.copyWith(hasPin: true, unlocked: true),
    );
  }

  Future<void> enableLock() async {
    if (state.value?.hasPin != true) return;
    await _storage.write(key: _lockKey, value: 'true');
    state = AsyncValue.data(state.value!.copyWith(lockEnabled: true));
  }

  Future<void> disableLock() async {
    await _storage.write(key: _lockKey, value: 'false');
    state = AsyncValue.data(
      state.value!.copyWith(lockEnabled: false, unlocked: true),
    );
  }

  Future<void> clearPin() async {
    await _storage.delete(key: _pinKey);
    await _storage.write(key: _lockKey, value: 'false');
    state = AsyncValue.data(
      state.value!.copyWith(hasPin: false, lockEnabled: false, unlocked: true),
    );
  }
}

final pinProvider = AsyncNotifierProvider<PinNotifier, PinState>(
  PinNotifier.new,
);
