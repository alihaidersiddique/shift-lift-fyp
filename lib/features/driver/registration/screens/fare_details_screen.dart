import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shift_lift/commons/app_drawer.dart';

import '../../../../utils/app_colors.dart';

class FareDetailsScreen extends StatelessWidget {
  const FareDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBFBFB),
      appBar: AppBar(
        elevation: 2.0,
        title: const Text("Fare Details"),
        actions: const [
          AppDrawer(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          // ride duration
          FareWidget(
            title: "Duration & Distance",
            label1: LabelsRowWidget(title: "Ride duration", amount: "7 mins"),
            label2: LabelsRowWidget(title: "Distance covered", amount: "2 km"),
          ),

          // customer paid
          FareWidget(
            title: "Customer Paid",
            label1: LabelsRowWidget(title: "Ride fare", amount: "200"),
            label2: LabelsRowWidget(title: "Platform fee", amount: "50"),
            label6: Divider(),
            label3: LabelsRowWidget(
              title: "Subtotal",
              amount: "PKR 250",
              bold: true,
            ),
            label4: LabelsRowWidget(title: "VAT", amount: "6.7"),
            label7: Divider(),
            label5: LabelsRowWidget(
              title: "TOTAL",
              amount: "PKR 256.70",
              bold: true,
            ),
          ),

          // you received
          ColoredBox(
            color: AppColors.primaryColor,
            child: FareWidget(
              title: "You Recieved",
              label1: LabelsRowWidget(title: "Fix amount", amount: "50"),
              label2: LabelsRowWidget(title: "Ride amount", amount: "150"),
              label6: Divider(),
              label3: LabelsRowWidget(
                title: "Total",
                amount: "PKR 200",
                bold: true,
              ),
            ),
          ),
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
    this.label5,
    this.label6,
    this.label7,
  }) : super(key: key);

  final String title;
  final Widget label1;
  final Widget label2;
  final Widget? label3;
  final Widget? label4;
  final Widget? label5;
  final Widget? label6;
  final Widget? label7;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
          const SizedBox(height: 10),
          label2,
          label6 == null ? const SizedBox() : const SizedBox(height: 10),
          label6 ?? const SizedBox(),
          label3 == null ? const SizedBox() : const SizedBox(height: 10),
          label3 ?? const SizedBox(),
          label4 == null ? const SizedBox() : const SizedBox(height: 10),
          label4 ?? const SizedBox(),
          label7 == null ? const SizedBox() : const SizedBox(height: 10),
          label7 ?? const SizedBox(),
          label5 == null ? const SizedBox() : const SizedBox(height: 10),
          label5 ?? const SizedBox(),
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
    this.bold = false,
  }) : super(key: key);

  final String title;
  final String amount;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
