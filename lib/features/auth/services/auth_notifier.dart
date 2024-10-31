// ignore_for_file: deprecated_member_use_from_same_package, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.freezed.dart';
part 'auth_notifier.g.dart';

// Create an auth state class
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(UserModels user) = _Success;
  const factory AuthState.error(String message) = _Error;
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  AuthState build() => const AuthState.initial();

  Future<void> signUpWithEmailAndPassword(UserModels userModel) async {
    try {
      // Set loading state
      state = const AuthState.loading();

      // Create user with email and password
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );

      if (userModel.imageFile != null) {
        // Upload image
        final storageRef = _storage
            .ref()
            .child('UserImages')
            .child('${userCredential.user!.uid}.jpg');

        final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'uploaded-by': userCredential.user!.uid},
        );

        await storageRef.putFile(userModel.imageFile!, metadata);

        // Get image URL
        final imageUrl = await storageRef.getDownloadURL();

        // Create updated user model with image URL
        final updatedUser = userModel.copyWith(
          userid: userCredential.user!.uid,
          imageUrl: imageUrl,
          createdAt: DateTime.now(),
        );

        // Save user data to Firestore
        await _firestore
            .collection('UserDetails')
            .doc(userCredential.user!.uid)
            .set({
          'uid': updatedUser.userid,
          'email': updatedUser.email,
          'imageUrl': updatedUser.imageUrl,
          'userName': updatedUser.userName,
          'lastName': updatedUser.lastName,
          'time': updatedUser.createdAt,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Update state with success
        state = AuthState.success(updatedUser);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        state = const AuthState.error('The email address is already in use.');
      } else {
        state = AuthState.error('Something went wrong: ${e.message}');
      }
    } catch (e) {
      state = AuthState.error('Failed to sign up: $e');
    }
  }

  // Sign In
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else {
        print(e.message);
      }
    }
  }

  void refresh() {
    state = const AuthState.initial(); // Reset state to initial
  }

  //update user profile
  Future<void> updateUserProfile({
    required File newProfileImage,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('UserImages')
          .child('${user.uid}.jpg');

      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'uploaded-by': user.uid},
      );

      await storageRef.putFile(newProfileImage, metadata);
      final imageUrl = await storageRef.getDownloadURL();

      // Update only the imageUrl in Firestore
      await FirebaseFirestore.instance
          .collection('UserDetails')
          .doc(user.uid)
          .update({
        'imageUrl': imageUrl,
      });
    } catch (e) {
      throw Exception('Failed to update');
    }
  }
}

// Create a provider for current user
@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}
