import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/utils.dart';

class HomeIconText extends StatelessWidget {
  const HomeIconText({
    Key? key,
    required this.icon,
    required this.text,
    this.readOnly = false,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      cursorColor: AppColors.primaryColor,
      style: smHeading.copyWith(
        fontSize: 16,
        decoration: TextDecoration.none,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        fillColor: AppColors.secondaryColor,
        filled: true,
        icon: FaIcon(
          icon,
          color: Colors.white,
          size: 16,
        ),
        focusedBorder: readOnly == false
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              )
            : InputBorder.none,
        enabledBorder: readOnly == false
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              )
            : InputBorder.none,
        contentPadding: EdgeInsets.only(
          left: AppDimensions.width30,
          top: 0.0,
          bottom: 0.0,
        ),
        hintText: text,
        hintStyle: smHeading.copyWith(
          fontSize: 16,
          color: readOnly == false ? Colors.grey : Colors.white,
        ),
      ),
    );
  }
}
