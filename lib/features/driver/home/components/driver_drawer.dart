import 'package:flutter/material.dart';
import 'package:shift_lift/core/utils.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

import '../../../../utils/app_colors.dart';
import '../../../home/components/drawer_item_button.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const Text(
                "SHIFT LIFT",
                style: TextStyle(color: AppColors.primaryColor, fontSize: 22.0),
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 16,
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
                onPressed: () {},
              ),
              DrawerItemButton(
                icon: Icons.history,
                label: "Requests",
                onPressed: () {},
              ),
              DrawerItemButton(
                icon: Icons.man,
                label: "Profile",
                onPressed: () {},
              ),
              DrawerItemButton(
                icon: Icons.help,
                label: "Help",
                onPressed: () {},
              ),
              DrawerItemButton(
                icon: Icons.change_circle,
                label: "Rider",
                onPressed: () {
                  Navigator.pop(context);
                  navigateTo(context, '/home-screen');
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
