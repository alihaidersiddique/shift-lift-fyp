import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../commons/app_drawer.dart';
import '../../../../utils/app_colors.dart';
import 'fare_details_screen.dart';

class RidesHistroyScreen extends StatelessWidget {
  const RidesHistroyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rides Histroy"),
        actions: const [
          AppDrawer(),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20.0),
        itemCount: 5,
        itemBuilder: (context, index) => buildRideWidget(
          "1st May, 2021  12:00 PM",
          "500",
          "Model Colony, 144-C Surti Society, Near  Malir Cantt",
          "Gulshan-e-Iqbal, 13-D Pakri Bakery, Near Shalimar Garden",
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FareDetailsScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget buildRideWidget(dateAndTime, amount, pickUp, destination, onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 17, right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 0.25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "PKR ",
                      style: GoogleFonts.kadwa(
                        color: AppColors.primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: amount,
                      style: GoogleFonts.kadwa(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                dateAndTime,
                style: GoogleFonts.kadwa(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          buildIconTextWidget(
            Icons.circle_outlined,
            pickUp,
          ),
          const SizedBox(height: 15.0),
          buildIconTextWidget(
            Icons.circle,
            destination,
          ),
        ],
      ),
    ),
  );
}

Widget buildIconTextWidget(icon, text) {
  return Row(
    children: [
      Icon(icon, color: AppColors.primaryColor, size: 16.0),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: GoogleFonts.kadwa(color: Colors.black.withOpacity(0.3)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
