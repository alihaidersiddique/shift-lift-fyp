import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shift_lift/commons/loader.dart';
import 'package:shift_lift/features/auth/controller/auth_controller.dart';
import 'package:shift_lift/features/auth/screens/sign_in_screen.dart';
import 'commons/error_text.dart';
import 'core/models/user_model.dart';
import 'firebase_options.dart';
import 'router.dart';
import 'utils/app_colors.dart';
import 'utils/app_pallette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  Future<void> getData(WidgetRef ref, User data) async {
    userModel = await ref
        .read(authControllerProvider.notifier)
        .getUserData(data.phoneNumber!)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) {
            if (data != null) {
              if (userModel == null) {
                getData(ref, data);
              }
            }
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primaryColor: Palette.primaryColor,
                appBarTheme: const AppBarTheme(color: Colors.white),
                iconButtonTheme: const IconButtonThemeData(
                  style: ButtonStyle(
                    iconColor: MaterialStatePropertyAll(Colors.white),
                  ),
                ),
                useMaterial3: true,
              ),
              routeInformationParser: const RoutemasterParser(),
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (userModel != null) {
                  return loggedInRoute;
                }
                return loggedOutRoute;
              }),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
