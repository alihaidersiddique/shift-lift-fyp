import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shift_lift/utils/app_colors.dart';

import '../home_screen.dart';

class VehicleTileWidget extends ConsumerWidget {
  const VehicleTileWidget({
    super.key,
    required this.vehcileName,
    required this.vehcileCapacity,
    required this.vehicleImage,
    required this.suggestions,
    required this.onTap,
    required this.index,
  });

  final String vehcileName;
  final String vehcileCapacity;
  final String vehicleImage;
  final List<String> suggestions;
  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTileValue = ref.watch(selectedTileProvider);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffFFFFFF),
          border: Border.all(
            color: selectedTileValue == index
                ? AppColors.primaryColor
                : Colors.grey,
            width: selectedTileValue == index ? 1.5 : 0.25,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // vehcile image
                Image.asset(
                  vehicleImage,
                  height: 65,
                  width: 75,
                ),
                const SizedBox(width: 20.0),

                // vehcile name and capacity
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        vehcileName,
                        style: GoogleFonts.kadwa(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        vehcileCapacity,
                        style: GoogleFonts.kadwa(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // box image
                Center(child: Image.asset("assets/images/EmptyBox.png")),
              ],
            ),

            const Divider(),
            const SizedBox(height: 5.0),

            // suggestions box
            SizedBox(
              height: 40.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: suggestions.length,
                itemBuilder: (context, index) =>
                    SuggestItemWidget(text: suggestions[index]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SuggestItemWidget extends StatelessWidget {
  const SuggestItemWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 13.0),
        ),
      ),
    );
  }
}
