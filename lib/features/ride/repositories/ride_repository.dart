import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/ride_model.dart';

final rideRepositoryProvider =
    Provider<RideRepository>((ref) => RideRepository(ref: ref));

final loaderStatusProvider = StateProvider<bool>((ref) => false);

class RideRepository {
  RideRepository({
    required this.ref,
  });

  final ProviderRef ref;

  final CollectionReference _ridesCollection =
      FirebaseFirestore.instance.collection('rides');

  Future<DocumentReference> requestRide(RideModel ride) async {
    final docRef = await _ridesCollection.add(
      {
        'rideId': ride.rideId,
        'pickUpAddress': ride.pickUpAddress,
        'dropOffAddress': ride.dropOffAddress,
        'customerId': ride.customerId,
        'customerName': ride.customerName,
        'customerPhoto': ride.customerPhoto,
        'distance': ride.distance,
        'duration': ride.duration,
        'vehicleType': ride.vehicleType,
        'rideStatus': describeEnum(RideStatus.requested),
        'createdAt': FieldValue.serverTimestamp(),
        'dropOffLat': ride.dropOffLat,
        'dropOffLong': ride.dropOffLong,
        'pickUpLat': ride.pickUpLat,
        'pickUpLong': ride.pickUpLong,
      },
    );

    await _ridesCollection.doc(docRef.id).update({"rideId": docRef.id});

    return docRef;
  }

  // update ride status along with driver id
  Future<void> bookRide(String rideId, String driverId) async {
    try {
      // show the loader
      ref.read(loaderStatusProvider.notifier).update((state) => true);

      // update the `drivers` array
      await _ridesCollection.doc(rideId).update({
        'drivers': FieldValue.arrayUnion([driverId]),
      });

      // hide the loader
      ref.read(loaderStatusProvider.notifier).update((state) => false);
    } catch (error) {
      // handle the error
      ref.read(loaderStatusProvider.notifier).update((state) => false);
      debugPrint('Error booking ride: $error');
    }
  }

  // begin ride
  Future<void> beginRide(String rideId) async {
    await _ridesCollection.doc(rideId).update({
      'rideStatus': describeEnum(RideStatus.booked),
    });
  }

  // end ride
  Future<void> endRide(String rideId) async {
    await _ridesCollection.doc(rideId).update({
      'rideStatus': describeEnum(RideStatus.completed),
    });
  }

  // cancel ride and update ride status
  Future<void> cancelRide(String rideId) async {
    await _ridesCollection.doc(rideId).update({
      'rideStatus': describeEnum(RideStatus.cancelled),
    });
  }
}
