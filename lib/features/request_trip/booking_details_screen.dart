import 'package:flutter/material.dart';
import 'package:shift_lift/features/chat/chat_screen.dart';
import 'package:shift_lift/features/request_trip/drive_request_screen.dart';
import '../../utils/utils.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriveRequestScreen(),
                ),
              );
            },
            child: Text(
              "Cancel",
              style: smClHd.copyWith(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Center(
            child: Text(
              "Your carrier is on the way",
              style: mdClHd.copyWith(fontSize: 19),
            ),
          ),
          const SizedBox(height: 20.0),
          Card(
            elevation: 3.0,
            color: AppColors.secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      "assets/images/profile.jpg",
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndTextButton(
                        icon: Icons.call,
                        text: "Call",
                        onTap: () {},
                      ),
                      Text(
                        "Hamza\nMini Truck\nCS 0123E",
                        style: smClHd,
                        textAlign: TextAlign.center,
                      ),
                      IconAndTextButton(
                        icon: Icons.chat,
                        text: "Chat",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChatScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(),
                  const SizedBox(height: 10.0),
                  const DualTextWidget(
                    icon: "assets/icons/pick_up.png",
                    title: "Model Colony",
                    subTitle: "144-C Surti Society, Near Malir Cantt",
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Image.asset(
                        "assets/icons/line.png",
                      ),
                    ),
                  ),
                  const DualTextWidget(
                    icon: "assets/icons/drop_off.png",
                    title: "Gulshan e Iqbal",
                    subTitle: "Gulshan e Mehmood housing Society",
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const DualTextWidget(
                    icon: "assets/icons/offer.png",
                    title: "Estimated Cost",
                    subTitle: "PKR 300",
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const TextIconButton(icon: Icons.share, text: "Share ride details"),
          const SizedBox(height: 20.0),
          const TextIconButton(
              icon: Icons.support_agent, text: "Customer care"),
          const SizedBox(height: 20.0),
          const TextIconButton(
            icon: Icons.cancel,
            text: "Cancel Ride",
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class TextIconButton extends StatelessWidget {
  const TextIconButton(
      {Key? key, required this.text, required this.icon, this.color})
      : super(key: key);

  final String text;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          foregroundColor: color ?? AppColors.primaryColor,
        ),
        onPressed: () {},
        icon: Icon(icon),
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}

class DualTextWidget extends StatelessWidget {
  const DualTextWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 5.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: mdClHd.copyWith(
                fontSize: 12,
              ),
            ),
            Text(
              subTitle,
              style: smClHd,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )
      ],
    );
  }
}

class IconAndTextButton extends StatelessWidget {
  const IconAndTextButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      style: const ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(
          AppColors.secondaryColor,
        ),
        backgroundColor: MaterialStatePropertyAll(
          AppColors.primaryColor,
        ),
      ),
      icon: Icon(
        icon,
        size: 18,
      ),
      label: Text(text),
    );
  }
}
