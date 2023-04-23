import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shift_lift/core/constants/constants.dart';
import 'package:shift_lift/utils/app_colors.dart';

class RideRequestMapScreen extends ConsumerStatefulWidget {
  const RideRequestMapScreen({
    required this.source,
    required this.destination,
    super.key,
  });

  final LatLng source;
  final LatLng destination;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RideRequestMapScreenState();
}

class _RideRequestMapScreenState extends ConsumerState<RideRequestMapScreen> {
  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      AppText.kGoogleMapsApiKey,
      PointLatLng(widget.source.latitude, widget.source.longitude),
      PointLatLng(widget.destination.latitude, widget.destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    getPolyPoints();
    // source = ref.read(pickupLocationProvider);
    // destination = ref.read(dropoffLocationProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (context, ref, _) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.source,
              zoom: 17,
            ),
            polylines: {
              Polyline(
                polylineId: const PolylineId("route"),
                color: AppColors.primaryColor,
                width: 5,
                points: polylineCoordinates,
              ),
            },
            markers: {
              Marker(
                markerId: const MarkerId("source"),
                position: widget.source,
              ),
              Marker(
                markerId: const MarkerId("destination"),
                position: widget.destination,
              ),
            },
          );
        },
      ),
    );
  }
}
