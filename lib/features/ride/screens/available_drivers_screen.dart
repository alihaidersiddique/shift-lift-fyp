import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shift_lift/core/models/available_driver_model.dart';
import 'package:square_progress_bar/square_progress_bar.dart';
import '../../driver/home/controller/home_controller.dart';
import '../../map/controller/map_controller.dart';
import '../../../utils/utils.dart';
import '../controllers/ride_controller.dart';

class AvailableDriversScreen extends ConsumerStatefulWidget {
  const AvailableDriversScreen({super.key});

  @override
  ConsumerState<AvailableDriversScreen> createState() =>
      _AvailableDriversScreenState();
}

class _AvailableDriversScreenState
    extends ConsumerState<AvailableDriversScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: const FaIcon(
        //     FontAwesomeIcons.arrowLeft,
        //     color: Colors.black,
        //     size: 20,
        //   ),
        // ),
        // title: const Text(
        //   "Available Drivers",
        //   style: TextStyle(fontSize: 23.0),
        // ),
        // titleSpacing: 2,
        // backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 2,
        actions: [
          TextButton(
            onPressed: () {
              // ref.read(rideControllerProvider.notifier).cancelRide();
              Navigator.pop(context);
            },
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
      body: Consumer(
        builder: (context, ref, child) {
          final rideDrivers = ref.watch(availableDriversProvider);

          return rideDrivers.when(
            data: (drivers) {
              if (drivers.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 40.0),
                    Center(
                      child: Text(
                        'Finding drivers...',
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    // clipBehavior: Clip.antiAlias,
                    // scrollDirection: Axis.vertical,
                    height: 400,
                    viewportFraction: 0.92,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.bounceInOut,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.6,
                  ),
                  items: drivers.map((driver) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SquareProgressBar(
                          progress:
                              1.2, // provide the progress in a range from 0.0 to 1.0
                          isAnimation:
                              true, // default: false, animate the progress of the bar
                          animationDuration: const Duration(seconds: 5),
                          solidBarColor: AppColors
                              .secondaryColor, // default: blue, main bar color
                          emptyBarColor: AppColors.primaryColor.withOpacity(
                            0.2,
                          ), // default: gray, empty bar color
                          strokeWidth: 10, // default: 15, bar width
                          barStrokeCap: StrokeCap
                              .square, // default: StrokeCap.round, bar cap shape
                          isRtl: true, // default: false, bar start point
                          gradientBarColor: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: <Color>[
                              AppColors.primaryColor,
                              AppColors.primaryColor
                            ],
                            tileMode: TileMode.repeated,
                          ),

                          child: DriverCardWidget(driver: driver, ref: ref),
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) {
              // debugPrint("error ....$error");
              // debugPrint("error stack trace ....$stackTrace");
              return const Center(
                child: Text('An error occurred while loading drivers.'),
              );
            },
          );
        },
      ),
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
    required this.driver,
    required this.ref,
  }) : super(key: key);

  final AvailableDriverModel driver;
  final WidgetRef ref;

  Future<void> acceptDriver(
      String driverPhone, String rideId, BuildContext context) {
    return ref
        .read(rideControllerProvider.notifier)
        .acceptDriver(driverId: driverPhone, rideId: rideId, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 2.0,
      color: Colors.white,
      shape: const RoundedRectangleBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // time and price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${driver.duration} min."),
                const BoldPriceWidget(),
                Text("${driver.distance} m"),
              ],
            ),
            const SizedBox(height: 40.0),

            // photo
            Container(
              height: 100,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                driver.photoUrl ??
                    "https://firebasestorage.googleapis.com/v0/b/shift-lift-31fd9.appspot.com/o/no-user.png?alt=media&token=2cf37a39-dbe4-4292-8e3c-5c3e80d94a21",
              ),
            ),
            const SizedBox(height: 10.0),

            // name
            Text(
              driver.displayName!,
              style: mdClHd.copyWith(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 5.0),

            // rating and reviews
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.orangeAccent,
                  size: 16,
                ),
                const SizedBox(width: 5.0),
                Text("${driver.rating}"),
                Text("${driver.comments}"),
              ],
            ),
            const SizedBox(height: 20.0),

            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const SizedBox(height: 10.0),
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
                  onTap: () async {
                    await acceptDriver(
                        driver.phoneNumber!, driver.rideId!, context);
                  },
                ),
              ],
            )
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
    return SizedBox(
      // width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(bgColor),
        ),
        child: Text(
          text,
          style: smHeading.copyWith(color: textColor, fontSize: 14),
        ),
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
