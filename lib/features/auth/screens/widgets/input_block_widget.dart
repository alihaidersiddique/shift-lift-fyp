import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utils/app_colors.dart';

class InputBlockWidget extends StatelessWidget {
  InputBlockWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      height: 50,
      width: 40,
      alignment: Alignment.center,
      color: Colors.white,
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.primaryColor,
        onChanged: (value) {
          if (value.length == 1 && value.length < 6) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.titleLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
