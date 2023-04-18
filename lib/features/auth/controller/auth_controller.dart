import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/user_model.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/utils.dart';
import '../repository/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, UserModel>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

class AuthController extends StateNotifier<UserModel> {
  final AuthRepository _authRepository;
  final Ref _ref;

  String verify = "";
  String pin = "";

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(UserModel(uid: "", phoneNumber: ""));

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Future<void> signInWithPhone(
    BuildContext context,
    String phoneNumber,
  ) async {
    await _authRepository.signInWithPhone(
      phoneNumber,
      (phoneAuthCredential) async {
        final auth = _ref.read(authProvider);

        UserCredential userCredential =
            await auth.signInWithCredential(phoneAuthCredential);

        await _authRepository.saveUserData(userCredential.user!);

        navigateTo(context, '/name-screen');
      },
      (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          String error = 'The provided phone number is not valid.';
          debugPrint(error);
          showSnackBar(context, error);
        }

        // Handle other errors
      },
      (verificationId, forceResendingToken) async {
        //Handle code sent
        verify = verificationId;
      },
      (verificationId) {
        // Handle code auto-retrieval timeout
      },
    );
  }

  Future<UserModel> getUserData(String phoneNumber) async {
    final user = await _authRepository.getUserData(phoneNumber);

    state = state.copyWith(
      uid: user.uid,
      phoneNumber: user.phoneNumber,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
      mode: user.mode,
      email: user.email,
      address: user.address,
      dateOfBirth: user.dateOfBirth,
      gender: user.gender,
    );

    return user;
  }

  Future<void> updateProfileImage(String photoUrl, BuildContext context) async {
    try {
      state = state.copyWith(photoUrl: photoUrl);

      showCircularProgressIndicator(context);

      final res =
          await _authRepository.updateProfileImage(state.phoneNumber, photoUrl);

      res.fold(
        (l) {
          Navigator.pop(context);
          showSnackBar(context, l.message);
        },
        (r) {
          Navigator.pop(context);
          showSnackBar(context, "Profile Picture updated successfully!");
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateDisplayName(String name, BuildContext context) async {
    try {
      state = state.copyWith(displayName: name);

      showCircularProgressIndicator(context);

      final res =
          await _authRepository.updateDisplayName(state.phoneNumber, name);

      res.fold(
        (l) {
          Navigator.pop(context);
          showSnackBar(context, l.message);
        },
        (r) {
          Navigator.pop(context);
          showSnackBar(context, "Name updated successfully!");
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateAddress(String address, BuildContext context) async {
    try {
      state = state.copyWith(address: address);

      showCircularProgressIndicator(context);

      final res =
          await _authRepository.updateAddress(state.phoneNumber, address);

      res.fold(
        (l) {
          Navigator.pop(context);
          showSnackBar(context, l.message);
        },
        (r) {
          Navigator.pop(context);
          showSnackBar(context, "Address updated successfully!");
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateDateOfBirth(String dob, BuildContext context) async {
    try {
      state = state.copyWith(dateOfBirth: dob);

      showCircularProgressIndicator(context);

      final res =
          await _authRepository.updateDateOfBirth(state.phoneNumber, dob);

      res.fold(
        (l) {
          Navigator.pop(context);
          showSnackBar(context, l.message);
        },
        (r) {
          Navigator.pop(context);
          showSnackBar(context, "Date of Birth updated successfully!");
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateGender(String gender, BuildContext context) async {
    try {
      state = state.copyWith(gender: gender);

      showCircularProgressIndicator(context);

      final res = await _authRepository.updateGender(state.phoneNumber, gender);

      res.fold(
        (l) {
          Navigator.pop(context);
          showSnackBar(context, l.message);
        },
        (r) {
          Navigator.pop(context);
          showSnackBar(context, "Gender updated successfully!");
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
