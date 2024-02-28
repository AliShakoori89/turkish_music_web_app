import 'package:flutter/material.dart';
import '../../../const/custom_divider.dart';
import '../../../helpers/widgets/about_button.dart';
import '../../../helpers/widgets/exit_account-button.dart';
import '../../../helpers/widgets/exit_button.dart';
import '../../../helpers/widgets/help_button.dart';
import '../../../helpers/widgets/report_button.dart';
import '../../../helpers/widgets/share_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.033,
          left: MediaQuery.of(context).size.width * 0.033,
          top: MediaQuery.of(context).size.height * 0.08,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
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
            ShareButton(),
            ReportButton(),
            HelpButton(),
            AboutButton(),
            ExitAccountButton(),
            ExitButton()
          ],
        ),
      ),
    );
  }
}



