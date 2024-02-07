import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:turkish_music_app/presentation/helpers/custom_card.dart';

import '../../../const/custom_divider.dart';
import '../../../helpers/custom_page_with_cards.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.033,
          left: MediaQuery.of(context).size.width * 0.033,
          top: MediaQuery.of(context).size.height * 0.08,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 8,
                          right: 8,
                          bottom: 10
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person_outline_rounded),
                          SizedBox(width: 10),
                          Text("Profile Email"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        right: 10
                      ),
                      child: Text("alishakoori89@gmail.com",
                      style: TextStyle(
                        color: Colors.grey
                      )),
                    ),
                  ],
                ),
                CustomDivider(
                    dividerColor : Colors.grey
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                final String appLink = 'https://play.google.com/store/apps/details?id=com.example.myapp';
                final String message = 'Check out my new app: $appLink';

                // Share the app link and message using the share dialog
                await FlutterShare.share(title: 'Share App', text: message, linkUrl: appLink);
              },
              child: const CustomCard(
                  title: "Share",
                  customIcon: Icons.share,
                  customColor: Colors.grey),
            ),
            const CustomCard(
                title: "report",
                customIcon: Icons.report,
                customColor: Colors.grey),
            const CustomCard(
                title: "help",
                customIcon: Icons.help,
                customColor: Colors.grey),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 8,
                          bottom: 10
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/custom_icons/about.png",width: 20,
                          color: Colors.white),
                          const SizedBox(width: 10),
                          const Text("About"),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                      size: 20,)
                  ],
                ),
                CustomDivider(
                    dividerColor : Colors.grey
                ),
              ],
            ),
            const CustomCard(
                title: "Exit",
                customIcon: Icons.exit_to_app,
                customColor: Colors.grey)
          ],
        ),
      ),
    );
  }
}
