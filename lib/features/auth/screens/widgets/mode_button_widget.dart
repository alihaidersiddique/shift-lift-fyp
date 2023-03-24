import 'package:flutter/material.dart';

class ModeButtonWidget extends StatelessWidget {
  const ModeButtonWidget({
    super.key,
    required this.name,
    required this.onPress,
  });

  final String name;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: onPress,
        child: Text(name),
      ),
    );
  }
}
