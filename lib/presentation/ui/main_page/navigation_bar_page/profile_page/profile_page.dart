import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/fetch_user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/fetch_user_bloc/state.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/profile_page/profile_page_widget/about_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/profile_page/profile_page_widget/report_button.dart';
import '../../../../bloc/fetch_user_bloc/event.dart';
import '../../../../const/custom_divider.dart';
import 'profile_page_widget/exit_account-button.dart';
import 'profile_page_widget/exit_button.dart';
import 'profile_page_widget/help_button.dart';
import 'profile_page_widget/share_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<FetchUserBloc>(context).add(GetCurrentUserEvent());

    return Scaffold(
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.033,
              left: MediaQuery.of(context).size.width * 0.033,
              top: MediaQuery.of(context).size.height * 0.08,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 8, right: 8, bottom: 10),
                            child: Row(
                              children: [
                                Icon(Icons.person_outline_rounded),
                                SizedBox(width: 10),
                                Text("Profile Email"),
                              ],
                            ),
                          ),
                          BlocBuilder<FetchUserBloc, FetchUserState>(
                              builder: (context, state) {
                                var user = state.user;
                                return Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(user.data!.email!,
                                      style: TextStyle(color: Colors.grey)),
                                );
                              }),
                        ],
                      ),
                      CustomDivider(dividerColor: Colors.grey),
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
          )),
    );
  }
}



