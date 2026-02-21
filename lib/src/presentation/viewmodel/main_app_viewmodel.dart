import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainAppViewmodel extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void changeTab(int index) {
    state = index;
  }
}

final navIndexProvider = NotifierProvider<MainAppViewmodel, int>(() {
  return MainAppViewmodel();
});
