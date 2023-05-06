import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../commons/app_drawer.dart';
import '../../../../core/constants/constants.dart';
import '../../../../utils/commons/app_button.dart';
import '../../../home/components/vehicle_tile_widget.dart';
import '../widgets/form_step_widget.dart';
import 'driver_basic_info_screen.dart';

final selectedTileProvider = StateProvider<int>((ref) => -1);

class DriverVehicleSelectionScreen extends ConsumerStatefulWidget {
  DriverVehicleSelectionScreen({super.key});

  @override
  ConsumerState<DriverVehicleSelectionScreen> createState() =>
      _DriverVehicleSelectionScreenState();
}

class _DriverVehicleSelectionScreenState
    extends ConsumerState<DriverVehicleSelectionScreen> {
  Future<QuerySnapshot> fetchAppVehicles() async =>
      await FirebaseFirestore.instance.collection('appVehicles').get();

  final TextEditingController _rideTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Text(
          AppText.selectvehi,
          style: GoogleFonts.kadwa(color: Colors.black),
        ),
        actions: const [
          AppDrawer(),
        ],
      ),
      body: Column(
        children: [
          // step 1
          const FormStepWidget(text: "1/6"),

          // // form
          verticalSlider(ref),
        ],
      ),
      bottomNavigationBar: AppButton(
        text: AppText.next,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DriverBasicInfoScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget verticalSlider(WidgetRef ref) {
    return Expanded(
      child: FutureBuilder<QuerySnapshot>(
        future: fetchAppVehicles(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => VehicleTileWidget(
                index: index,
                onTap: () {
                  ref
                      .read(selectedTileProvider.notifier)
                      .update((state) => index);

                  _rideTypeController.text =
                      snapshot.data!.docs[index]['vehicleName'];
                },
                vehcileName: snapshot.data!.docs[index]['vehicleName'],
                vehcileCapacity: snapshot.data!.docs[index]['vehicleCapacity'],
                vehicleImage: snapshot.data!.docs[index]['vehicleImage'],
                suggestions:
                    (snapshot.data!.docs[index]['suggestions'] as List<dynamic>)
                        .map((item) => item.toString())
                        .toList(),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 0.24),
      ),
      child: Text(name),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 0.24),
      ),
      child: const Text("Washing machines"),
    );
  }
}
