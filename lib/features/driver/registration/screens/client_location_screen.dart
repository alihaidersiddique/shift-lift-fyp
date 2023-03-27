import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_colors.dart';

class ClientLocationScreen extends StatelessWidget {
  const ClientLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppColors.primaryColor,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 100,
            color: AppColors.primaryColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60.0, top: 15),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.locationDot,
                        size: 27,
                        color: Colors.white,
                      ),
                      Text(
                        "PLot 24 E",
                        style: GoogleFonts.kadwa(
                            fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0, top: 8),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.locationArrow,
                        size: 27,
                        color: Colors.white,
                      ),
                      Text(
                        "Karimabad Bus Stop",
                        style: GoogleFonts.kadwa(
                            fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Image.asset("assets/images/map.jpg"),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 80.0,
              top: 10,
              right: 60,
              bottom: 5,
            ),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffEAEAF9),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Text(
                      "-5",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40,
                  ),
                  child: Column(
                    children: [
                      Text("PKR 187",
                          style: GoogleFonts.kadwa(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor)),
                      Text("current fair",
                          style: GoogleFonts.kadwa(
                              fontSize: 12, color: AppColors.primaryColor)),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Text(
                      "+5",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: const Size(280, 40)),
            child: Text(
              "Raise Fair",
              style: GoogleFonts.kadwa(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize: const Size(150, 40)),
                  child: Text(
                    "Accpet",
                    style: GoogleFonts.kadwa(fontSize: 18, color: Colors.white),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize: const Size(150, 40)),
                  child: Text(
                    "Decline",
                    style: GoogleFonts.kadwa(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
