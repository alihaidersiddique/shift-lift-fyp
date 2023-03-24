import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/utils.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 140),
            Image.asset(
              "assets/images/app_icon.png",
              height: 40,
            ),
            const SizedBox(height: 20.0),
            Text(
              "Hello",
              style: mdClHd.copyWith(fontSize: 42.0),
            ),
            Text(
              "lets introduce",
              style: smClHd.copyWith(
                color: Colors.grey[400],
                fontSize: 26.0,
              ),
            ),
            const SizedBox(height: 80.0),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffBDBDBD),
                  ),
                ),
                hintText: "First Name",
                hintStyle: smClHd.copyWith(
                  color: Colors.grey[400],
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffBDBDBD),
                  ),
                ),
                hintText: "Last Name",
                hintStyle: smClHd.copyWith(
                  color: Colors.grey[400],
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 160.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // context.go('/');
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 75,
                  child: ElevatedButton(
                    onPressed: () {
                      // context.go('/mode-screen');
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.arrowRight,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
