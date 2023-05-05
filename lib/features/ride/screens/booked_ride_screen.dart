import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookedRideScreen extends ConsumerWidget {
  const BookedRideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Ride'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20.0),
              const LinearProgressIndicator(),
              const SizedBox(height: 30.0),
              const Center(
                child: Text(
                  'Your rider is on the way!',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30.0),
              const Center(
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('assets/images/driver_image.png'),
                ),
              ),
              const SizedBox(height: 8.0),
              const Center(
                child: Text(
                  'Ali',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 8.0),
              const Center(
                child: Text(
                  'Toyota Corolla, License Plate ABC123',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),
              const Text(
                'Pickup Location',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Yadgar Fish, Jamshed Road, Karachi',
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Drop-off Location',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Pizza Munch, Gurumandir, Karachi',
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),
              const Text(
                'Ride Details',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Ride Type',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Text(
                    'Pickup',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Estimated Time of Arrival',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Text(
                    '5 mins',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Distance',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Text(
                    '3.2 mi',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              // const SizedBox(height: 36.0),
              // const Text(
              //   'Driver Information',
              //   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
