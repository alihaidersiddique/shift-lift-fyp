import 'package:flutter/material.dart';

import 'package:shift_lift/utils/app_colors.dart';
import 'package:shift_lift/utils/app_dimensions.dart';
import 'package:shift_lift/utils/app_text_styles.dart';

import '../../utils/commons/app_button.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int current = 0;

  final PageController _pageController = PageController(initialPage: 0);

  List<String> tabBars = ["All", "Get Started", "Ordering & Payments"];

  static const body =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";

  List<Item> items = [
    Item(header: "1. How can I book ?", body: body),
    Item(header: "2. How to set my location?", body: body),
    Item(header: "3. How to search the driver?", body: body),
    Item(header: "4. How to filter my search?", body: body),
    Item(header: "5. How can I add my card?", body: body),
    Item(header: "6. How to complete payment?", body: body),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
        leading: BackButton(
          color: Colors.white,
          // onPressed: () => context.go('/home'),
        ),
      ),
      body: Column(
        children: [
          //
          SizedBox(height: AppDimensions.height20 * 2),
          // tab-bars
          SizedBox(
            height: AppDimensions.height30 * 2,
            width: double.infinity,
            child: ListView.builder(
              itemCount: tabBars.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: AppDimensions.width10),
                  child: AppButton(
                    text: tabBars[index],
                    onTap: () {
                      setState(() => current = index);
                      _pageController.animateToPage(
                        current,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linearToEaseOut,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          //
          SizedBox(height: AppDimensions.height20 * 2),
          // Questions
          Expanded(
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (value) {
                setState(() => current = value);
              },
              children: [
                // all
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                              color: items[index].isExpanded == true
                                  ? Colors.white
                                  : AppColors.primaryColor,
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
                            style: TextStyle(
                              fontSize: 18,
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
                SizedBox(),
                // ordering and payments
                SizedBox(),
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
