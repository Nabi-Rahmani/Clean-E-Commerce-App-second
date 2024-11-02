// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final itemsProvider = StateNotifierProvider<ItemsNotifier, List<int>>((ref) {
//   return ItemsNotifier();
// });

// class ItemsNotifier extends StateNotifier<List<int>> {
//   ItemsNotifier() : super(List.generate(20, (index) => index));

//   Future<void> refreshItems() async {
//     // Simulate a network call
//     await Future.delayed(const Duration(seconds: 2));
//     state = List.generate(20, (index) => index + state.length); // Add new items
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';

final refreshCountProvider = StateProvider<int>((ref) => 0);
final refreshProvider = StateNotifierProvider<RefreshNotifier, bool>((ref) {
  return RefreshNotifier();
});

class RefreshNotifier extends StateNotifier<bool> {
  RefreshNotifier() : super(false);

  Future<void> refreshPage() async {
    state = true; // Start refresh
    try {
      // Add any additional refresh logic here
      await Future.delayed(const Duration(seconds: 1)); // Simulate some work
    } finally {
      state = false; // End refresh
    }
  }
}
