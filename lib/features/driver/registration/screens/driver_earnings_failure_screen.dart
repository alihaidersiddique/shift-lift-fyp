import 'package:flutter/material.dart';

import '../../../../commons/app_drawer.dart';

class DriverEarningsFailureWithdrawScreen extends StatelessWidget {
  const DriverEarningsFailureWithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdrawal Failed'),
        elevation: 2.0,
        actions: const [
          AppDrawer(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              'Withdrawal Failed',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Unsufficient balance in your account.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
