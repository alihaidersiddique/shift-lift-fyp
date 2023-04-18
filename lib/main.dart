import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_lift/features/auth/controller/auth_controller.dart';
import 'core/models/user_model.dart';
import 'core/utils/app_routes.dart';
import 'firebase_options.dart';
import 'utils/app_pallette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    getData(ref);
    super.initState();
  }

  // UserModel? userModel;

  Future<void> getData(WidgetRef ref) async {
    ref.read(authControllerProvider.notifier).authStateChange.listen((event) {
      if (event != null) {
        ref
            .read(authControllerProvider.notifier)
            .getUserData(event.phoneNumber!);
        // updateUserProvider(event);
      }
    });
  }

  // void updateUserProvider(User event) async {
  //   userModel = await ref
  //       .read(authControllerProvider.notifier)
  //       .getUserData(event.phoneNumber!);
  //   ref.read(userProvider.notifier).update((state) => userModel);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Palette.primaryColor,
        appBarTheme: const AppBarTheme(color: Colors.white),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.black)),
        ),
        useMaterial3: true,
      ),
      routerConfig: appRoutes,
    );
  }
}
