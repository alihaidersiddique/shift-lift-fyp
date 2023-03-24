import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_lift/core/providers/firebase_providers.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/models/user_model.dart';
import 'package:routemaster/routemaster.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: ref.read(authProvider), firestore: ref.read(firestoreProvider)),
);

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> signInWithPhone(
    String phoneNumber,
    Function(AuthCredential) verificationCompletedCallback,
    Function(FirebaseAuthException) verificationFailedCallback,
    Function(String, int?) codeSentCallback,
    Function(String) codeAutoRetrievalTimeoutCallback,
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompletedCallback,
      verificationFailed: verificationFailedCallback,
      codeSent: codeSentCallback,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeoutCallback,
    );
  }

  Future<void> saveUserData(User user) async {
    UserModel userModel = UserModel(
      uid: user.uid,
      phoneNumber: user.phoneNumber!,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );

    await _users.doc(user.phoneNumber).set(userModel.toMap());

    debugPrint("user data saved...");
  }

  void createUserIfNotExists(User user, BuildContext context) async {
    final exists = await doesUserExist(user.phoneNumber);

    if (exists) {
      Routemaster.of(context).push('/home-screen');
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.phoneNumber)
          .set({
        'uid': user.uid,
        'displayName': user.displayName,
        'photoUrl': user.photoURL,
        'phoneNumber': user.phoneNumber,
      });

      Routemaster.of(context).push('/name-screen');
    }
  }

  Future<bool> doesUserExist(String? phoneNumber) async {
    try {
      final userDoc = await _users.doc(phoneNumber).get();
      return userDoc.exists;
    } catch (e) {
      // Log the error and re-throw it to propagate it to the calling method
      debugPrint('Error checking if user exists: $e');
      rethrow;
    }
  }

  Stream<UserModel> getUserData(String phoneNumber) {
    return _users.doc(phoneNumber).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
