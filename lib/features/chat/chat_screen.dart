import 'package:flutter/material.dart';
import 'package:shift_lift/utils/utils.dart';

import '../../commons/rider_drawer_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        actions: const [
          CustomerDrawerWidget(),
        ],
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.secondaryColor,
                  width: 2,
                ),
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                  "assets/images/profile.jpg",
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            const Text("Hasnain Raza"),
          ],
        ),
      ),
      body: Column(
        children: [
          // chats
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              children: [
                Center(
                  child: Text(
                    "Tuesday, 18 Oct. 11:02 pm",
                    style: smClHd.copyWith(fontSize: 12.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                const OthersChatStyle(
                  message: "Will be there in 10 mins.",
                ),
                const SizedBox(height: 20.0),
                const UserChatStyle(message: "Come Fast.. brother"),
                const SizedBox(height: 20.0),
                const OthersChatStyle(
                  message: "Yeah dropping the passenger..",
                ),
                const SizedBox(height: 20.0),
                const UserChatStyle(message: "Come Fast.. "),
                const SizedBox(height: 20.0),
                const OthersChatStyle(
                  message: "Will be there in 10 mins.",
                ),
                const SizedBox(height: 20.0),
                const UserChatStyle(message: "Come Fast.. "),
                const SizedBox(height: 20.0),
                const OthersChatStyle(
                  message: "Will be there in 10 mins.",
                ),
                const SizedBox(height: 20.0),
                const UserChatStyle(message: "Come Fast.. "),
                const SizedBox(height: 20.0),
                const OthersChatStyle(
                  message: "Will be there in 10 mins.",
                ),
                const SizedBox(height: 20.0),
                const UserChatStyle(message: "Come Fast.. "),
                const SizedBox(height: 20.0),
                const OthersChatStyle(
                  message: "Will be there in 10 mins.",
                ),
                const SizedBox(height: 20.0),
                const UserChatStyle(message: "Come Fast.. "),
                const SizedBox(height: 20.0),
                const OthersChatStyle(
                  message: "Will be there in 10 mins.",
                ),
                const SizedBox(height: 20.0),
                const UserChatStyle(message: "Come Fast.. "),
              ],
            ),
          ),
          // bottom bar
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            color: AppColors.primaryColor,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/icons/upload_icon.png",
                      )),
                ),
                const SizedBox(width: 15.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 212,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            border: InputBorder.none,
                            hintText: "Text message",
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/icons/happy-icon.png",
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/icons/microphone-icon.png",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserChatStyle extends StatelessWidget {
  final String message;

  const UserChatStyle({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // message box
        Container(
          margin: EdgeInsets.only(bottom: AppDimensions.height5),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.width30,
            vertical: AppDimensions.height20,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.radius15),
              bottomRight: Radius.circular(AppDimensions.radius15),
              topRight: Radius.circular(AppDimensions.radius15),
            ),
          ),
          // width: AppDimensions.width30 * 8,
          child: Text(
            message,
            style: smClHd.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: AppDimensions.width15),
        // other person
        CircleAvatar(
          backgroundImage: const AssetImage(
            "assets/images/person.jpg",
          ),
          radius: AppDimensions.radius30,
        ),
      ],
    );
  }
}

class OthersChatStyle extends StatelessWidget {
  final String message;

  const OthersChatStyle({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // other person
        CircleAvatar(
          backgroundImage: const AssetImage(
            "assets/images/profile.jpg",
          ),
          radius: AppDimensions.radius30,
        ),
        //
        SizedBox(width: AppDimensions.width15),
        // message box
        Container(
          margin: EdgeInsets.only(bottom: AppDimensions.height5),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.width30,
            vertical: AppDimensions.height20,
          ),
          decoration: BoxDecoration(
            color: AppColors.othersChatColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.radius15),
              bottomRight: Radius.circular(AppDimensions.radius15),
              topRight: Radius.circular(AppDimensions.radius15),
            ),
          ),
          child: Text(
            message,
            style: smClHd.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
