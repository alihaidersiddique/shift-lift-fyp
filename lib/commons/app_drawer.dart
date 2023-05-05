import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/home/components/rider_drawer.dart';
import '../utils/app_colors.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: IconButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.black87),
        ),
        onPressed: () async => openDrawer(context, ref),
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        color: AppColors.primaryColor,
      ),
    );
  }
}
