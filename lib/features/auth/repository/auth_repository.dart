import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shift_lift/core/providers/firebase_providers.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/models/user_model.dart';
import '../../../core/type_defs.dart';

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

  FutureVoid signInWithPhone(
    String phoneNumber,
    Function(AuthCredential) verificationCompletedCallback,
    Function(FirebaseAuthException) verificationFailedCallback,
    Function(String, int?) codeSentCallback,
    Function(String) codeAutoRetrievalTimeoutCallback,
  ) async {
    try {
      return right(
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompletedCallback,
          verificationFailed: verificationFailedCallback,
          codeSent: codeSentCallback,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeoutCallback,
        ),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> saveUserData(User user) async {
    UserModel userModel = UserModel(
      uid: user.uid,
      phoneNumber: user.phoneNumber!,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      driverProfile: false,
      address: "",
      email: "",
      dateOfBirth: "",
      gender: "",
    );

    await _users.doc(user.phoneNumber).set(userModel.toMap());

    debugPrint("user data saved...");
  }

  Future<UserModel> getUserData(String phoneNumber) async {
    final userDocument = await _users.doc(phoneNumber).get();
    final userData = userDocument.data() as Map<String, dynamic>;
    final userModel = UserModel.fromMap(userData);
    return userModel;
  }

  FutureVoid updateProfileImage(String? phoneNumber, String photoUrl) async {
    try {
      return right(
          await _users.doc(phoneNumber).update({'photoUrl': photoUrl}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateDisplayName(String? phoneNumber, String name) async {
    try {
      return right(await _users.doc(phoneNumber).update({'displayName': name}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateAddress(String? phoneNumber, String address) async {
    try {
      return right(await _users.doc(phoneNumber).update({'address': address}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateDateOfBirth(String? phoneNumber, String dob) async {
    try {
      return right(await _users.doc(phoneNumber).update({'dateOfBirth': dob}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateGender(String? phoneNumber, String gender) async {
    try {
      return right(await _users.doc(phoneNumber).update({'gender': gender}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
