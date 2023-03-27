import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_colors.dart';
import 'fare_detail_screen.dart';

class RideHistroyScreen extends StatelessWidget {
  const RideHistroyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: AppColors.primaryColor,
        ),
        title: Text(
          "Ride Histroy",
          style: GoogleFonts.kadwa(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const DoubleTextWidget(
          customerId: "#rd1234",
          title: "title",
          subTitle: "subTitle",
          icon: FontAwesomeIcons.locationArrow,
        ),
      ),
    );
  }
}

class DoubleTextWidget extends StatelessWidget {
  const DoubleTextWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.customerId,
  }) : super(key: key);

  final String title;
  final String customerId;
  final String subTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FareDetailScreen(),
          ),
        );
      },
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
            Text(
              customerId,
              style: GoogleFonts.kadwa(
                  color: AppColors.primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15.0),
            const DataRowWidget(
                icon: FontAwesomeIcons.locationDot,
                title: "Model Colony",
                subTitle: "144-C Surti Society, Near  Malir Cantt"),
            const SizedBox(height: 15.0),
            const DataRowWidget(
                icon: FontAwesomeIcons.locationArrow,
                title: "Gulshan e Iqbal",
                subTitle: "Gulshan e Mehmood Housing Society"),
            const SizedBox(height: 15.0),
            const DataRowWidget(
              icon: FontAwesomeIcons.moneyBill,
              title: "Recived Payment",
              subTitle: "PKR 300",
            ),
          ],
        ),
      ),
    );
  }
}

class DataRowWidget extends StatelessWidget {
  const DataRowWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.kadwa(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 4),
            Text(
              subTitle,
              style: GoogleFonts.kadwa(color: AppColors.primaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
