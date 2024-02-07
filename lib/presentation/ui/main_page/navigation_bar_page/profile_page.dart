import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/custom_card.dart';

import '../../../const/custom_divider.dart';
import '../../../helpers/custom_page_with_cards.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  List customIcon = [
    Icons.exit_to_app
  ];
  List title = [
    "Exit"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.033,
          left: MediaQuery.of(context).size.width * 0.033,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.033,
            ),
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
                          Text("Profile Imail"),
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
