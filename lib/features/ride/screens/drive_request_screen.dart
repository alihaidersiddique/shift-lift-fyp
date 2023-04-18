import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../map/controller/map_controller.dart';
import '../../../utils/utils.dart';

import 'package:flutter/services.dart' show rootBundle;

GoogleMapController? myMapController;

class DriveRequestScreen extends ConsumerStatefulWidget {
  const DriveRequestScreen({super.key});

  @override
  ConsumerState<DriveRequestScreen> createState() => _DriveRequestScreenState();
}

class _DriveRequestScreenState extends ConsumerState<DriveRequestScreen> {
  late GoogleMapController _controller;
  final Completer<GoogleMapController> _controllerCompleter = Completer();

  String? _mapStyle;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
            size: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          //
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10.0),

          // drivers
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 0.7,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return const DriverCardWidget();
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10.0),

          // map
          Expanded(
            child: Consumer(builder: (context, ref, _) {
              return GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controllerCompleter.complete(controller);
                  _controller = controller;
                  _controller.setMapStyle(_mapStyle);
                },
                initialCameraPosition: CameraPosition(
                  target: ref.read(dropoffLocationProvider),
                  zoom: 17,
                ),
                zoomControlsEnabled: false,
                markers: ref.read(markersProvider),
                polylines: <Polyline>{ref.read(mapPolylineProvider)},
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  SizedBox buildBottomBar() {
    return SizedBox(
      height: 115,
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            left: AppDimensions.height30,
            right: AppDimensions.height30,
          ),
          child: Consumer(builder: (contex0t, ref, _) {
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const FaIcon(
                    FontAwesomeIcons.locationDot,
                    color: Colors.black,
                    size: 20,
                  ),
                  title: Text(
                    ref.read(sourceLocationProvider).toString(),
                    style: smClHd.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const FaIcon(
                    FontAwesomeIcons.locationArrow,
                    color: Colors.black,
                    size: 20,
                  ),
                  title: Text(
                    ref.read(destinationLocationProvider).toString(),
                    style: smClHd.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class DriverCardWidget extends StatelessWidget {
  const DriverCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 1st row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("3 min."),
                BoldPriceWidget(),
                Text("571 m"),
              ],
            ),

            // 2nd row
            Row(
              children: [
                // image box
                Container(
                  height: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset("assets/images/profile.jpg"),
                ),
                const SizedBox(width: 10.0),

                // name box
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hammad Tahir",
                      style: mdClHd.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.orangeAccent,
                          size: 16,
                        ),
                        SizedBox(width: 5.0),
                        Text("4.8"),
                        Text("(65)"),
                      ],
                    )
                  ],
                ),
              ],
            ),

            // 3rd row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RideButtonWidget(
                  bgColor: Colors.grey.withOpacity(0.05),
                  text: "Decline",
                  textColor: Colors.black,
                  onTap: () {},
                ),
                RideButtonWidget(
                  bgColor: AppColors.primaryColor,
                  text: "Accept",
                  textColor: Colors.white,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RideButtonWidget extends StatelessWidget {
  const RideButtonWidget({
    super.key,
    required this.bgColor,
    required this.text,
    required this.textColor,
    required this.onTap,
  });

  final Color bgColor;
  final String text;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(bgColor),
      ),
      child: Text(
        text,
        style: smHeading.copyWith(color: textColor, fontSize: 14),
      ),
    );
  }
}

class BoldPriceWidget extends StatelessWidget {
  const BoldPriceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "PKR 187",
      style: mdClHd,
    );
  }
}
