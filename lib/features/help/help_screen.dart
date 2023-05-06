import 'package:flutter/material.dart';
import 'package:shift_lift/commons/app_drawer.dart';

import 'package:shift_lift/utils/app_colors.dart';
import 'package:shift_lift/utils/app_dimensions.dart';
import 'package:shift_lift/utils/app_text_styles.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  int current = 0;

  final PageController _pageController = PageController(initialPage: 0);

  List<String> tabBars = ["All", "Get Started", "Ordering & Payments"];

  List<Item> items = [
    Item(
      header: "1. How can I book ride?",
      body:
          "Navigate to the home screen, input pickUp location and destination, select vehicle, and tap on the book ride button.",
    ),
    Item(
      header: "2. How to set pick-up location?",
      body: "body",
    ),
    Item(
      header: "3. How to search the driver?",
      body: "body",
    ),
    Item(
      header: "4. How to edit my profile?",
      body: "body",
    ),
    Item(
      header: "5. How can I add my bank card?",
      body: "body",
    ),
    Item(
      header: "6. How to complain?",
      body: "body",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
        actions: const [
          AppDrawer(),
        ],
      ),
      body: Column(
        children: [
          // Questions
          Expanded(
            child: PageView(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (value) {
                setState(() => current = value);
              },
              children: [
                // all
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ExpansionPanelList(
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (index, isExpanded) {
                      setState(() => items[index].isExpanded = !isExpanded);
                    },
                    children: List.generate(
                      items.length,
                      (index) => ExpansionPanel(
                        backgroundColor: items[index].isExpanded == true
                            ? AppColors.primaryColor
                            : Colors.white,
                        isExpanded: items[index].isExpanded,
                        canTapOnHeader: true,
                        headerBuilder: (context, isExpanded) => ListTile(
                          contentPadding: EdgeInsets.only(
                              left: AppDimensions.width30,
                              top: AppDimensions.height10),
                          title: Text(
                            items[index].header.toString(),
                            style: smClHd.copyWith(
                              fontSize: 18,
                              color: items[index].isExpanded == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        body: ListTile(
                          contentPadding: EdgeInsets.only(
                            left: AppDimensions.width30 - AppDimensions.width5,
                            right: AppDimensions.width15,
                            bottom: AppDimensions.height20,
                          ),
                          title: Text(
                            items[index].body.toString(),
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              height: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // get started
                const SizedBox(),
                // ordering and payments
                const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  final String? body;
  final String? header;
  bool isExpanded;

  Item({
    this.body,
    this.header,
    this.isExpanded = false,
  });
}
