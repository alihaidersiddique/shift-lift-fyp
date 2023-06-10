import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../commons/rider_drawer_widget.dart';
import '../../../../utils/app_colors.dart';

class PayBillScreen extends ConsumerStatefulWidget {
  PayBillScreen({super.key});

  @override
  ConsumerState<PayBillScreen> createState() => _PayBillScreenState();
}

class _PayBillScreenState extends ConsumerState<PayBillScreen> {
  bool _isPayingWithCard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pay Bill"),
        actions: const [
          CustomerDrawerWidget(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Method',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Pay with card
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPayingWithCard = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _isPayingWithCard
                            ? AppColors.primaryColor
                            : Colors.grey[400]!,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: _isPayingWithCard
                              ? AppColors.primaryColor
                              : Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pay with card',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isPayingWithCard
                                ? AppColors.primaryColor
                                : Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                  child: VerticalDivider(),
                ),
                // Pay with cash
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPayingWithCard = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _isPayingWithCard
                            ? Colors.grey[400]!
                            : AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "PKR",
                          style: TextStyle(
                            color: _isPayingWithCard
                                ? Colors.grey[400]
                                : AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pay with cash',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isPayingWithCard
                                ? Colors.grey[400]
                                : AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              _isPayingWithCard ? 'Card Details' : '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            _isPayingWithCard ? _buildCardDetailsForm() : const SizedBox(),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayBillScreen(),
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
                  "Pay",
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

  // Widget _buildCashDetailsForm() {
  //   return Column(
  //     children: [
  //       TextFormField(
  //         decoration: const InputDecoration(
  //           labelText: 'Name',
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       TextFormField(
  //         decoration: const InputDecoration(
  //           labelText: 'Phone Number',
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       TextFormField(
  //         decoration: const InputDecoration(
  //           labelText: 'Address',
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildCardDetailsForm() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Card Number',
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Expiration Date',
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'CVV',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name on Card',
          ),
        ),
      ],
    );
  }
}
