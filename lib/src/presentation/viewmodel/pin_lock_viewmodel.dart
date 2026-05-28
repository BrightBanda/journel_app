import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/presentation/viewmodel/pin_notifier.dart';

class PinLockUiState {
  final String? errorMessage;
  final bool isSuccess;

  const PinLockUiState({this.errorMessage, this.isSuccess = false});

  PinLockUiState copyWith({String? errorMessage, bool? isSuccess}) {
    return PinLockUiState(
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class PinLockViewModel extends AsyncNotifier<PinLockUiState> {
  @override
  Future<PinLockUiState> build() async {
    return const PinLockUiState();
  }

  Future<bool> verifyCurrentPin(String pin) async {
    if (state.isLoading) return false;

    if (pin.length < 4) {
      state = AsyncData(
        state.value!.copyWith(errorMessage: 'Enter your 4-digit PIN'),
      );
      return false;
    }

    state = const AsyncLoading<PinLockUiState>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      // Look up the stored value from storage directly to bypass provider mutations
      final storedPin = await ref
          .read(pinProvider.notifier)
          .getStoredPinDirectly();

      if (storedPin != null && storedPin == pin) {
        return const PinLockUiState(isSuccess: true, errorMessage: null);
      } else {
        return const PinLockUiState(
          isSuccess: false,
          errorMessage: 'Incorrect PIN',
        );
      }
    });

    return state.value?.isSuccess ?? false;
  }

  Future<bool> createNewPin(String pin, String confirmation) async {
    if (state.isLoading) return false;

    if (pin.length != 4) {
      state = AsyncData(
        state.value!.copyWith(errorMessage: 'PIN must be 4 digits'),
      );
      return false;
    }

    if (pin != confirmation) {
      state = AsyncData(
        state.value!.copyWith(errorMessage: "PINs don't match"),
      );
      return false;
    }

    state = const AsyncLoading<PinLockUiState>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      return const PinLockUiState(isSuccess: true, errorMessage: null);
    });

    return !state.hasError && (state.value?.isSuccess ?? false);
  }

  void resetState() {
    state = const AsyncData(PinLockUiState());
  }
}

final pinLockViewModelProvider =
    AsyncNotifierProvider<PinLockViewModel, PinLockUiState>(() {
      return PinLockViewModel();
    });
