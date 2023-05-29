import 'package:flutter/material.dart';
import 'package:shift_lift/features/driver/home/components/driver_drawer.dart';

import '../../../../commons/app_drawer.dart';

class DriverWithdrawalsScreen extends StatelessWidget {
  DriverWithdrawalsScreen({super.key});

  final List<Withdrawal> withdrawalHistory = [
    Withdrawal(
      id: 1,
      amount: 200,
      date: "12/04/2023",
      status: WithdrawalStatus.successful,
    ),
    Withdrawal(
      id: 2,
      amount: 500,
      date: "15/04/2023",
      status: WithdrawalStatus.successful,
    ),
    Withdrawal(
      id: 3,
      amount: 800,
      date: "18/04/2023",
      status: WithdrawalStatus.failed,
    ),
    Withdrawal(
      id: 4,
      amount: 120,
      date: "01/05/2023",
      status: WithdrawalStatus.successful,
    ),
    Withdrawal(
      id: 5,
      amount: 2000,
      date: "02/05/2023",
      status: WithdrawalStatus.successful,
    ),
    Withdrawal(
      id: 6,
      amount: 300,
      date: "05/05/2023",
      status: WithdrawalStatus.failed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdrawals'),
        elevation: 2.0,
        actions: const [
          DriverDrawerWidget(),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: withdrawalHistory.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Text(
              'Withdrawal #${withdrawalHistory[index].id}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Amount: PKR ${withdrawalHistory[index].amount.toStringAsFixed(2)}\n'
              'Date: ${withdrawalHistory[index].date}',
            ),
            trailing:
                withdrawalHistory[index].status == WithdrawalStatus.successful
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
          );
        },
      ),
    );
  }
}

class Withdrawal {
  final int id;
  final double amount;
  final String date;
  final WithdrawalStatus status;

  Withdrawal({
    required this.id,
    required this.amount,
    required this.date,
    required this.status,
  });
}

enum WithdrawalStatus {
  successful,
  failed,
}
