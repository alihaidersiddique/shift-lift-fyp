import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Step 3: Create a model for the ride details
class RideDetails {
  String pickupLocation;
  String destinationLocation;
  String rideType;

  RideDetails({
    required this.pickupLocation,
    required this.destinationLocation,
    required this.rideType,
  });

  Map<String, dynamic> toMap() {
    return {
      'pickup_location': pickupLocation,
      'destination_location': destinationLocation,
      'ride_type': rideType,
    };
  }
}

// Step 4: Create a provider to manage the state of the ride booking process
final rideBookingProvider =
    StateNotifierProvider.autoDispose<RideBookingNotifier, AsyncValue<String>>(
  (ref) => RideBookingNotifier(),
);

class RideBookingNotifier extends StateNotifier<AsyncValue<String>> {
  RideBookingNotifier() : super(const AsyncValue.data(''));

  Future<void> bookRide(RideDetails rideDetails) async {
    if (!mounted) {
      return; // widget is no longer mounted, do not proceed
    } else {
      try {
        state = const AsyncValue.loading();

        // Save ride details to Firestore
        final collectionRef = FirebaseFirestore.instance.collection('rides');
        await collectionRef.add(rideDetails.toMap());

        state = const AsyncValue.data('Ride booked successfully!');
      } catch (error) {
        state =
            AsyncValue.error('Failed to book ride: $error', StackTrace.current);
      }
    }
  }
}
