import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shift_lift/core/utils.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

import '../../../../utils/app_colors.dart';
import '../../../home/components/drawer_item_button.dart';

class DriverDrawerWidget extends StatelessWidget {
  const DriverDrawerWidget({
    super.key,
  });

  void openDrawer(BuildContext context) async {
    await showTopModalSheet<String?>(
      context,
      Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    // navigateTo(context, "/driver-ongoing-ride-screen");
                    Get.toNamed("/driver-ongoing-ride-screen");
                  },
                  icon: const Icon(
                    Icons.incomplete_circle,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // navigateTo(context, "/driver-profile-screen");
                    Get.toNamed("/driver-profile-screen");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        const AssetImage("assets/images/person.jpg"),
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black87),
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Wrap(
              runSpacing: 10.0,
              spacing: 25.0,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                DrawerItemButton(
                  icon: Icons.home,
                  label: "Home",
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed("/driver-home-screen");
                  },
                ),
                DrawerItemButton(
                  icon: Icons.history,
                  label: "History",
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed("/driver-rides-history-screen");
                  },
                ),
                DrawerItemButton(
                  icon: Icons.help,
                  label: "Earnings",
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed("/driver-earnings-screen");
                  },
                ),
                DrawerItemButton(
                  icon: Icons.change_circle,
                  label: "Withdrawals",
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed("/driver-withdrawals-screen");
                  },
                ),
              ],
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: IconButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.black87),
        ),
        onPressed: () async => openDrawer(context),
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        color: AppColors.primaryColor,
      ),
    );
  }
}
