import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:turkish_music_app/presentation/bloc/download_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/download_bloc/event.dart';
import '../../../../../data/model/save_song_model.dart';
import '../../../../main.dart';
import '../../../bloc/download_bloc/state.dart';

class DownloadButton extends StatefulWidget {

  final String songFilePath;
  final String songName;
  final SaveSongModel songModel;
  const DownloadButton({super.key,
    required this.songFilePath,
    required this.songName,
    required this.songModel
  });

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {

  late TargetPlatform platform;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          BlocProvider.of<DownloadBloc>(context).add(
              DownloadFileEvent(songFilePath: widget.songFilePath,
                  songName: widget.songName, platform: platform));
        },
        icon: BlocConsumer<DownloadBloc, DownloadState>(

            listener: (context, state) async {
              if(state.status.isSuccess){
                Fluttertoast.showToast(
                    msg: "Download Successfully .",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 3,
                    backgroundColor: const Color(
                        0xFF00B01E).withOpacity(0.2),
                    textColor: Colors.white,
                    fontSize: 16.0
                );

                // Show local notification
                AndroidNotificationDetails androidDetails =
                AndroidNotificationDetails(
                  'download_channel', // channel ID
                  'Download Notifications', // channel name
                  channelDescription: 'Channel for download completion notifications',
                  importance: Importance.high,
                  priority: Priority.high,
                  actions: <AndroidNotificationAction>[
                    AndroidNotificationAction(
                      'id_open', // Unique ID for the action
                      'Open Song', // Button label
                      icon: DrawableResourceAndroidBitmap('id_open', // Optional: add custom drawable icon
                    ),),
                    AndroidNotificationAction(
                      'id_dismiss', // Action ID
                      'Dismiss', // Button label
                      icon: DrawableResourceAndroidBitmap('id_dismiss', // Optional: add custom drawable icon
                      ),
                    ),
                  ]
                );

                NotificationDetails notificationDetails =
                NotificationDetails(android: androidDetails);

                await flutterLocalNotificationsPlugin.show(
                  0, // Notification ID
                  'Download Complete', // Notification title
                  '${widget.songName} has been downloaded successfully.', // Notification body
                  notificationDetails,
                  payload: widget.songFilePath,
                );

              }else if(state.status.isError){
                Fluttertoast.showToast(
                    msg: "Download Failed .",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 3,
                    backgroundColor: const Color(
                        0xFFC20808).withOpacity(0.2),
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            },
            builder: (context, state) {
              if (state.status.isInitial) {
                return Icon(
                  Icons.download_sharp,
                  size: MediaQuery.of(context).size.height / 40,
                  color: Colors.grey,
                );
              } else if (state.status.isLoading) {
                return SizedBox(
                  width: MediaQuery.of(context).size.height / 40,
                  height: MediaQuery.of(context).size.height / 40,
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                );
              } else if (state.status.isSuccess) {
                return Icon(Icons.download_sharp,
                    size: MediaQuery.of(context).size.height / 40,
                    color: Colors.grey);
              } else if (state.status.isError) {
                return Icon(Icons.download_sharp,
                    size: MediaQuery.of(context).size.height / 40,
                    color: Colors.grey);
              }
              return Container(
                width: MediaQuery.of(context).size.height / 40,
                height: MediaQuery.of(context).size.height / 40,
                color: Colors.black,
              );
            })
      //
    );
  }

}
