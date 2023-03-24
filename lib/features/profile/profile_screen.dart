import 'package:flutter/material.dart';
import 'package:shift_lift/utils/app_colors.dart';
import 'package:shift_lift/utils/commons/app_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  String? selectedGender;

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.primaryColor,
                    AppColors.secondaryColor,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: BackButton(
              color: Colors.white,
              // onPressed: () => context.go('/home'),
            ),
          ),
          Positioned(
            top: 105,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1,
                ),
              ),
              child: const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                  "assets/images/profile.jpg",
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  TextFormField(
                    readOnly: false,
                    decoration: const InputDecoration(
                      hintText: "Muhammad Ali Haider",
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "+92 336 3359047",
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText:
                          "House No.271 Mehrabad Colony, near New Shamshi Govt. School",
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Email",
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2010),
                          lastDate: DateTime(2030));
                      if (picked != null && picked != _selectedDate) ;
                      // setState(() {
                      //   _selectedDate = picked;
                      // });
                    },
                    decoration: const InputDecoration(
                      hintText: "28/05/1999",
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: selectedGender,
                    onChanged: (String? newValue) {},
                    hint: const Text("Gender"),
                    items: <String>['male', 'female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AppButton(
              text: "Save",
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
