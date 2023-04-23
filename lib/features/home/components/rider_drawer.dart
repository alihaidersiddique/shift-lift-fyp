import 'package:flutter/material.dart';
import 'package:shift_lift/core/utils.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

import '../../../utils/app_colors.dart';
import 'drawer_item_button.dart';

void openDrawer(BuildContext context) async {
  await showTopModalSheet<String?>(
    context,
    Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const Text(
                "SHIFT LIFT",
                style: TextStyle(color: AppColors.primaryColor, fontSize: 22.0),
              ),

              //
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),

          //
          SizedBox(
            height: 90.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                DrawerItemButton(
                  icon: Icons.home,
                  label: "Home",
                  onPressed: () {},
                ),
                SizedBox(width: 15.0),
                DrawerItemButton(
                  icon: Icons.history,
                  label: "Requests",
                  onPressed: () {},
                ),
                SizedBox(width: 15.0),
                DrawerItemButton(
                  icon: Icons.man,
                  label: "Profile",
                  onPressed: () {
                    Navigator.pop(context);
                    navigateTo(context, '/profile-screen');
                  },
                ),
                SizedBox(width: 15.0),
                DrawerItemButton(
                  icon: Icons.help,
                  label: "Help",
                  onPressed: () {},
                ),
                SizedBox(width: 15.0),
                DrawerItemButton(
                  icon: Icons.change_circle,
                  label: "Driver",
                  onPressed: () {
                    Navigator.pop(context);
                    navigateTo(context, '/driver-home-screen');
                  },
                ),
                SizedBox(width: 15.0),
                DrawerItemButton(
                  icon: Icons.change_circle,
                  label: "Driver",
                  onPressed: () {
                    Navigator.pop(context);
                    navigateTo(context, '/driver-home-screen');
                  },
                ),
                SizedBox(width: 15.0),
                DrawerItemButton(
                  icon: Icons.change_circle,
                  label: "Driver",
                  onPressed: () {
                    Navigator.pop(context);
                    navigateTo(context, '/driver-home-screen');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    ),
  );
}
