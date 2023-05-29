import 'package:flutter/material.dart';

import '../../../../commons/app_drawer.dart';

class DriverSuccessfulWithdrawScreen extends StatelessWidget {
  const DriverSuccessfulWithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdrawal Successful'),
        elevation: 2.0,
        actions: const [
          AppDrawer(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              'You have successfully withdrawn:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'PKR ${1200.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
