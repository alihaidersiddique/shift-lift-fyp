import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/models/client_model.dart';
import '../../../../utils/app_colors.dart';
import 'current_ride_status_screen.dart';

class ClientRequestScreeen extends StatelessWidget {
  ClientRequestScreeen({super.key});

  List<ClientModel> requests = [
    ClientModel(
      time: '3 min',
      distance: '571m',
      amount: 120,
      profileImage: 'assets/images/profile.jpg',
      mapImage: 'assets/images/map.jpg',
      clientName: 'Ali Haider',
      pickUp: 'Saddar',
      dropOff: 'Shah Faisal',
    ),
    ClientModel(
      time: '2 hr',
      distance: '12km',
      amount: 320,
      profileImage: 'assets/images/profile.jpg',
      mapImage: 'assets/images/map.jpg',
      clientName: 'Ali Hassan',
      pickUp: 'PECHS',
      dropOff: 'Shah Faisal',
    ),
    ClientModel(
      time: '45 min',
      distance: '57km',
      amount: 3420,
      profileImage: 'assets/images/profile.jpg',
      mapImage: 'assets/images/map.jpg',
      clientName: 'Haider',
      pickUp: 'Malir',
      dropOff: 'Korangi',
    ),
    ClientModel(
      time: '3 hr',
      distance: '324m',
      amount: 160,
      profileImage: 'assets/images/profile.jpg',
      mapImage: 'assets/images/map.jpg',
      clientName: 'Adeen',
      pickUp: 'Johar',
      dropOff: 'Gulshan',
    ),
    ClientModel(
      time: '32 min',
      distance: '364m',
      amount: 345,
      profileImage: 'assets/images/profile.jpg',
      mapImage: 'assets/images/map.jpg',
      clientName: 'Minhaj',
      pickUp: 'Rizvia',
      dropOff: 'Malir',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: AppColors.primaryColor,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.jpg"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final client = requests[index];
            return ClientRequestModel(
              amount: client.amount,
              clientName: client.clientName,
              distance: client.distance,
              dropOff: client.dropOff,
              pickUp: client.pickUp,
              profileImage: client.profileImage,
              mapImage: client.mapImage,
              time: client.time,
            );
          },
        ),
      ),
    );
  }
}

class ClientRequestModel extends StatelessWidget {
  const ClientRequestModel({
    Key? key,
    required this.time,
    required this.distance,
    required this.amount,
    required this.profileImage,
    required this.mapImage,
    required this.clientName,
    required this.pickUp,
    required this.dropOff,
  }) : super(key: key);

  final String time;
  final String distance;
  final double amount;
  final String profileImage;
  final String mapImage;
  final String clientName;
  final String pickUp;
  final String dropOff;

  @override
  Widget build(BuildContext context) {
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
        children: [
          Row(
            children: [
              Text(
                time,
                style: GoogleFonts.kadwa(fontSize: 15),
              ),
              const Spacer(),
              Text("PKR ${amount.toString()}",
                  style: GoogleFonts.kadwa(
                      fontSize: 24,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(distance, style: GoogleFonts.kadwa(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 20),

          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // pic box
              Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                height: 100,
                child: Image.asset(
                  profileImage,
                ),
              ),
              const SizedBox(width: 10.0),

              // text box
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    clientName,
                    style: GoogleFonts.kadwa(fontSize: 20),
                  ),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.locationDot,
                        size: 12,
                      ),
                      Text(
                        pickUp,
                        style: GoogleFonts.kadwa(fontSize: 13),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.locationArrow,
                        size: 12,
                      ),
                      Text(
                        dropOff,
                        style: GoogleFonts.kadwa(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),

              // map box
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CurrentRideStatusScreen(),
                    ),
                  );
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  height: 100,
                  child: Image.asset(
                    mapImage,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
