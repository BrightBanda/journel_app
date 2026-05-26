import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journel_new/src/presentation/viewmodel/pin_lock_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/pin_notifier.dart';

// ==========================================
// PIN LOCK PAGE
// ==========================================
class PinLockPage extends ConsumerStatefulWidget {
  const PinLockPage({super.key});

  @override
  ConsumerState<PinLockPage> createState() => _PinLockPageState();
}

class _PinLockPageState extends ConsumerState<PinLockPage> {
  final _controller = TextEditingController();
  String? _error;
  bool _checking = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _attempt() async {
    if (_checking) return;
    if (_controller.text.length < 4) {
      setState(() => _error = 'Enter your 4-digit PIN');
      return;
    }
    setState(() {
      _checking = true;
      _error = null;
    });
    final ok = await ref.read(pinProvider.notifier).verify(_controller.text);
    if (!mounted) return;
    if (!ok) {
      setState(() {
        _error = 'Incorrect PIN';
        _checking = false;
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 64,
                color: Color(0xFFD4A853),
              ),
              const SizedBox(height: 24),
              Text(
                'Journel is Locked',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFD4A853),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your 4-digit PIN to continue',
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 220,
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.dmSans(
                    fontSize: 28,
                    letterSpacing: 12,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    errorText: _error,
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD4A853)),
                    ),
                  ),
                  onSubmitted: (_) => _attempt(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _checking ? null : _attempt,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4A853),
                  foregroundColor: const Color(0xFF1A1A1A),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  _checking ? 'Checking…' : 'Unlock',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// VERIFY PIN DIALOG INTERFACE
// ==========================================
Future<bool> verifyPinDialog(BuildContext context, WidgetRef ref) async {
  ref.read(pinLockViewModelProvider.notifier).resetState();

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => const _VerifyPinDialogContent(),
  );

  return result ?? false;
}

// Internal implementation component for Verify Dialog
class _VerifyPinDialogContent extends ConsumerStatefulWidget {
  const _VerifyPinDialogContent();

  @override
  ConsumerState<_VerifyPinDialogContent> createState() =>
      _VerifyPinDialogContentState();
}

class _VerifyPinDialogContentState
    extends ConsumerState<_VerifyPinDialogContent> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(pinLockViewModelProvider);
    final uiState = asyncState.value ?? const PinLockUiState();
    final isLoading = asyncState.isLoading;

    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: const Text('Confirm PIN'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        enabled: !isLoading,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          counterText: '',
          hintText: 'Current PIN',
          errorText: uiState.errorMessage,
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: isLoading
              ? null
              : () async {
                  final success = await ref
                      .read(pinLockViewModelProvider.notifier)
                      .verifyCurrentPin(_controller.text);

                  if (success) {
                    await ref
                        .read(pinProvider.notifier)
                        .verify(_controller.text);
                    if (context.mounted) Navigator.of(context).pop(true);
                  } else {
                    _controller.clear();
                  }
                },
          child: Text(isLoading ? 'Checking...' : 'Confirm'),
        ),
      ],
    );
  }
}

// ==========================================
// SET NEW PIN DIALOG INTERFACE
// ==========================================
Future<String?> setPinDialog(BuildContext context, WidgetRef ref) async {
  ref.read(pinLockViewModelProvider.notifier).resetState();

  final result = await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => const _SetPinDialogContent(),
  );

  return result;
}

// Internal implementation component for Set Pin Dialog
class _SetPinDialogContent extends ConsumerStatefulWidget {
  const _SetPinDialogContent();

  @override
  ConsumerState<_SetPinDialogContent> createState() =>
      _SetPinDialogContentState();
}

class _SetPinDialogContentState extends ConsumerState<_SetPinDialogContent> {
  late final TextEditingController _pinCtrl;
  late final TextEditingController _confirmCtrl;

  @override
  void initState() {
    super.initState();
    _pinCtrl = TextEditingController();
    _confirmCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _pinCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(pinLockViewModelProvider);
    final uiState = asyncState.value ?? const PinLockUiState();
    final isLoading = asyncState.isLoading;

    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: const Text('Set New PIN'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _pinCtrl,
            autofocus: true,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            enabled: !isLoading,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              counterText: '',
              labelText: 'New PIN (4 digits)',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _confirmCtrl,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            enabled: !isLoading,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: '',
              labelText: 'Confirm PIN',
              errorText: uiState.errorMessage,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: isLoading
              ? null
              : () async {
                  final success = await ref
                      .read(pinLockViewModelProvider.notifier)
                      .createNewPin(_pinCtrl.text, _confirmCtrl.text);

                  if (success) {
                    await ref.read(pinProvider.notifier).setPin(_pinCtrl.text);
                    if (context.mounted)
                      Navigator.of(context).pop(_pinCtrl.text);
                  }
                },
          child: Text(isLoading ? 'Saving...' : 'Save'),
        ),
      ],
    );
  }
}
