import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import '../../../core/models/user_model.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/utils.dart';
import '../repository/auth_repository.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  String verify = "";
  String pin = "";

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Future<void> signInWithPhone(
    BuildContext context,
    String phoneNumber,
  ) async {
    await _authRepository.signInWithPhone(
      phoneNumber,
      (phoneAuthCredential) async {
        // Handle verification completed callback.. automatically looks for sms

        debugPrint("in verification completed callback");

        final auth = _ref.read(authProvider);

        UserCredential userCredential =
            await auth.signInWithCredential(phoneAuthCredential);

        await _authRepository.saveUserData(userCredential.user!);
        debugPrint("data saved");

        Routemaster.of(context).push('/name-screen');
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

  Stream<UserModel> getUserData(String phoneNumber) {
    return _authRepository.getUserData(phoneNumber);
  }
}
