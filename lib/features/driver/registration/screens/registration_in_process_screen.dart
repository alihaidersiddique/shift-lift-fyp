import 'package:flutter/material.dart';
import '../../home/components/driver_drawer.dart';

class RegistrationInProcessScreen extends StatelessWidget {
  const RegistrationInProcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: const Text("Registration Status"),
        automaticallyImplyLeading: false,
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 0),
          child: LinearProgressIndicator(),
        ),
        actions: const [
          DriverDrawerWidget(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(height: 16.0),
            Text(
              "Your registration is in process,",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Please check back soon.",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
