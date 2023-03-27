import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_colors.dart';

class FareDetailScreen extends StatelessWidget {
  const FareDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: AppColors.primaryColor,
        ),
        title: Text(
          "FARE DETAILS",
          style: GoogleFonts.kadwa(
              fontSize: 25,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: const [
          // you recieve
          FareWidget(
            title: "You Receive",
            label1: LabelsRowWidget(title: "Base Fare", amount: 1.80),
            label2: LabelsRowWidget(
                title: "Distance (32/.07 mi \n*\$1.4040/mi)", amount: 45.03),
            label3: LabelsRowWidget(
                title: "Time (38.89 min\n* \$0.1728/min)", amount: 6.72),
            label4: LabelsRowWidget(title: "Total", amount: 56.55),
          ),
          // customer paid
          FareWidget(
              title: "Customer Pays",
              label1: LabelsRowWidget(title: "Rider Payment", amount: 118.78),
              label2: LabelsRowWidget(title: "Total", amount: 121.78))
        ],
      ),
    );
  }
}

class FareWidget extends StatelessWidget {
  const FareWidget({
    Key? key,
    required this.title,
    required this.label1,
    required this.label2,
    this.label3,
    this.label4,
  }) : super(key: key);

  final String title;
  final Widget label1;
  final Widget label2;
  final Widget? label3;
  final Widget? label4;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xffFFFFFF),
        border: Border.all(color: Colors.grey, width: 0.25),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.kadwa(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
          ),
          const SizedBox(height: 20),
          label1,
          const SizedBox(height: 20),
          label2,
          label3 == null ? const SizedBox() : const SizedBox(height: 20),
          label3 ?? const SizedBox(),
          label4 == null ? const SizedBox() : const SizedBox(height: 20),
          label4 ?? const SizedBox(),
        ],
      ),
    );
  }
}

class LabelsRowWidget extends StatelessWidget {
  const LabelsRowWidget({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.kadwa(fontSize: 22, fontWeight: FontWeight.w100),
        ),
        const Spacer(),
        Text(
          "\$$amount",
          style: GoogleFonts.kadwa(fontSize: 22, fontWeight: FontWeight.w100),
        )
      ],
    );
  }
}
