import 'package:flutter/material.dart';
import 'package:shift_lift/commons/app_drawer.dart';
import 'package:shift_lift/core/utils.dart';
import 'package:shift_lift/utils/utils.dart';

class DriverEarningsScreen extends StatelessWidget {
  const DriverEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings'),
        elevation: 2.0,
        actions: const [
          AppDrawer(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Total Earnings:',
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
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.money,
                color: Colors.green,
              ),
              label: const Text(
                'Withdraw Earnings',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                navigateTo(
                    context, '/driver-earning-successful-withdraw-screen');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.history),
              label: const Text(
                'Withdraw History',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                navigateTo(context, '/driver-earnings-withdraw-history-screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
