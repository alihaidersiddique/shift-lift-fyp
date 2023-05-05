import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/app_colors.dart';
import '../../../map/screens/ride_request_map_screen.dart';
import '../../../ride/screens/available_drivers_screen.dart';

class CustomerRequestWidget extends ConsumerWidget {
  const CustomerRequestWidget({
    Key? key,
    required this.time,
    required this.distance,
    required this.amount,
    required this.profileImage,
    required this.clientName,
    required this.pickUp,
    required this.dropOff,
    required this.onAccept,
    required this.onDecline,
    required this.pickUpLatLng,
    required this.dropOffLatLng,
  }) : super(key: key);

  final String time;
  final String distance;
  final double amount;
  final String profileImage;
  final String clientName;
  final String pickUp;
  final String dropOff;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final LatLng pickUpLatLng;
  final LatLng dropOffLatLng;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // time price distance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$time min",
                style: GoogleFonts.kadwa(fontSize: 15),
              ),
              Text(
                "PKR 250",
                style: GoogleFonts.kadwa(
                    fontSize: 24,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Text("$distance km", style: GoogleFonts.kadwa(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 10.0),

          // name and map
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                clientName,
                style: GoogleFonts.kadwa(fontSize: 20),
              ),
              // map box
              GestureDetector(
                onTap: () => _showMap(
                  context,
                  pickUpLatLng,
                  dropOffLatLng,
                ),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 50.0,
                  width: 80.0,
                  child: Image.asset(
                    "assets/images/map.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RideButtonWidget(
                bgColor: Colors.red,
                text: "Decline",
                textColor: Colors.white,
                onTap: onDecline,
              ),
              RideButtonWidget(
                bgColor: Colors.green,
                text: "Accept",
                textColor: Colors.white,
                onTap: onAccept,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMap(context, source, destination) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            children: [
              ColoredBox(
                color: AppColors.primaryColor,
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_outlined, color: Colors.white),
                  ),
                ),
              ),
              RideRequestMapScreen(
                source: source,
                destination: destination,
              ),
            ],
          ),
        );
      },
    );
  }
}
