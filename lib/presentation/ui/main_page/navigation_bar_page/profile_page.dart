import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/mini_palying_container.dart';
import '../../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../../bloc/mini_playing_container_bloc/state.dart';
import '../../../bloc/user_bloc/event.dart';
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

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(GetCurrentUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
          BlocBuilder<MiniPlayingContainerBloc, MiniPlayingContainerState>(
              builder: (context, state) {

        bool visibility = state.visibility;

        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.033,
                left: MediaQuery.of(context).size.width * 0.033,
                top: MediaQuery.of(context).size.height * 0.08,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {

                                var user = state.user;
                                if(state.status.isLoading){
                                  return CircularProgressIndicator();
                                }else if(state.status.isSuccess){
                                  return Padding(
                                    padding: EdgeInsets.only(top: 20, right: 10),
                                    child: Text(user!.data!.email!,
                                        style: TextStyle(color: Colors.grey)),
                                  );
                                }else if(state.status.isError){
                                  return Container();
                                }
                                return Container();
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
            MiniPlayingContainer(visibility: visibility)
          ],
        );
      })),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}



