import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormStepWidget extends StatelessWidget {
  const FormStepWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 20.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 0.25),
        ),
        child: Text(
          text,
          style: GoogleFonts.kadwa(fontSize: 15),
        ),
      ),
    );
  }
}
