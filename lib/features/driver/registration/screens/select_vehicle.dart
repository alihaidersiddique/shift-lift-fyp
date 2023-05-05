import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../../utils/commons/app_button.dart';
import 'driver_basic_info_screen.dart';

class SelectVehicleScreen extends StatelessWidget {
  const SelectVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.black,
        ),
        title: Text(
          AppText.selectvehi,
          style: GoogleFonts.kadwa(color: Colors.black),
        ),
      ),
      body: ColoredBox(
        color: const Color(0xffFBFBFB),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Column(
            children: [
              // step 1
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 0.25),
                  ),
                  child: Text(
                    "1/8",
                    style: GoogleFonts.kadwa(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),

              // // form
              // Stack(
              //   children: [
              //     Positioned(
              //       top: 0,
              //       left: 100,
              //       child: Container(
              //         height: 100,
              //         color: Colors.red,
              //         child: const Text("data"),
              //       ),
              //     ),
              //     Positioned(
              //       child: Container(
              //         height: 200,
              //         width: double.infinity,
              //         padding: const EdgeInsets.all(20),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(12),
              //           color: const Color(0xffFFFFFF),
              //           border: Border.all(color: Colors.grey, width: 0.25),
              //         ),
              //         child: Row(
              //           children: [
              //             Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   const Spacer(),
              //                   Text(
              //                     "Large Truck",
              //                     style: GoogleFonts.kadwa(
              //                       fontSize: 25,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                   Text(
              //                     "up to 5 ton",
              //                     style: GoogleFonts.kadwa(
              //                       fontSize: 20,
              //                       color: const Color(0xff503E9D),
              //                     ),
              //                   ),
              //                   Image.asset("assets/images/EmptyBox.png")
              //                 ]),
              //             const SizedBox(
              //               width: 20,
              //             ),
              //             Wrap(
              //               direction: Axis.vertical,
              //               children: [
              //                 Row(
              //                   children: const [
              //                     CardItemWidget(name: "Sofas"),
              //                     SizedBox(width: 6),
              //                     CardItemWidget(name: "Refrigerator"),
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   height: 8,
              //                 ),
              //                 const CardItemWidget(name: "Washing Machine"),
              //                 const SizedBox(height: 8),
              //                 Row(
              //                   children: const [
              //                     CardItemWidget(name: "Tables"),
              //                     SizedBox(width: 6),
              //                     CardItemWidget(name: "Dryers"),
              //                     SizedBox(width: 6),
              //                     CardItemWidget(name: "Pallets"),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 8),

              // query banner
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                    color: const Color(0xffFFFCCF),
                    borderRadius: BorderRadius.circular(12)),
                child: RichText(
                  text: TextSpan(
                    text: 'For queries, please contact our\n ',
                    style: GoogleFonts.kadwa(color: Colors.black, fontSize: 15),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'customer support',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppButton(
        text: AppText.next,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DriverBasicInfoScreen(),
            ),
          );
        },
      ),
    );
  }
}

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 0.24),
      ),
      child: Text(name),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 0.24),
      ),
      child: const Text("Washing machines"),
    );
  }
}
