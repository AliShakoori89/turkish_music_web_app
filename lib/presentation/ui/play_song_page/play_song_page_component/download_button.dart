import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/download_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/download_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/download_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/download_song_bloc/event.dart';
import '../../../../data/model/save_song_model.dart';
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
        icon: BlocBuilder<DownloadBloc, DownloadState>(builder: (context, state) {
          if(state.status.isInitial ){
            return Icon(Icons.download_sharp,
              size: MediaQuery.of(context).size.height / 40,
              color: Colors.grey,);
          }
          else if(state.status.isLoading ){
            return SizedBox(
              width: MediaQuery.of(context).size.height / 40,
              height: MediaQuery.of(context).size.height / 40,
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          else if(state.status.isSuccess){
            return Icon(Icons.download_sharp,
                size: MediaQuery.of(context).size.height / 40,
              color: Colors.grey);
          }
          else if(state.status.isError){
            return Icon(Icons.download_sharp,
                size: MediaQuery.of(context).size.height / 40,
              color: Colors.grey);
          }
          return Container(
            width: MediaQuery.of(context).size.height / 40,
            height: MediaQuery.of(context).size.height / 40,
            color: Colors.black,);
    })
        //
    );
  }

}
