import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_colors.dart';
import 'fare_details_screen.dart';

class DriverOnGoingRideScreen extends StatelessWidget {
  const DriverOnGoingRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "On-Going Ride",
        ),
        leading: const BackButton(
          color: AppColors.primaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildUserWidget(
                  'Passenger',
                  'assets/images/profile.jpg',
                  'Hasnain Raza',
                ),
                const SizedBox(
                  height: 140,
                  child: VerticalDivider(),
                ),
                buildUserWidget(
                  'Driver',
                  'assets/images/driver_image.png',
                  'Ali',
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Divider(),
            const SizedBox(height: 10.0),
            const Text(
              'Pickup Location',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Yadgar Fish, Jamshed Road, Karachi',
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Drop-off Location',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Pizza Munch, Gurumandir, Karachi',
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 10.0),
            const Divider(),
            Expanded(
              child: Image.asset(
                "assets/images/map.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 20.0),

            //
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FareDetailsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: const Size(280, 40),
                ),
                child: Text(
                  "Finish Ride",
                  style: GoogleFonts.kadwa(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Column buildUserWidget(String mode, String image, String name) {
    return Column(
      children: [
        Text(
          mode,
          style: GoogleFonts.kadwa(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Center(
          child: CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage(image),
          ),
        ),
        const SizedBox(height: 8.0),
        Center(
          child: Text(
            name,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
