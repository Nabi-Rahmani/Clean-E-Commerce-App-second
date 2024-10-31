// ignore_for_file: deprecated_member_use_from_same_package
// This class for updating the user profile
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/auth/services/auth_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'usedetails_notifier.g.dart';

@riverpod
FirebaseFirestore firestore(FirestoreRef ref) => FirebaseFirestore.instance;

// Stream provider for products
@riverpod
Stream<QuerySnapshot> productsStream(ProductsStreamRef ref) {
  final user = ref.watch(authStateChangesProvider).value;

  if (user == null) return const Stream.empty();

  return ref
      .watch(firestoreProvider)
      .collection('UserDetails')
      .where('uid', isEqualTo: user.uid)
      .snapshots();
}

// Optional: Notifier for product operations
@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> deleteProduct(String productId) async {
    state = const AsyncLoading();

    try {
      await ref
          .read(firestoreProvider)
          .collection('UserDetails')
          .doc(productId)
          .delete();

      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
