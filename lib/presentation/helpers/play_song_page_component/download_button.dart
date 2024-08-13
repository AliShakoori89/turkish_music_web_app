import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/download_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/download_bloc/event.dart';
import '../../bloc/download_bloc/state.dart';

class DownloadButton extends StatefulWidget {

  final String songFilePath;
  final String songName;
  const DownloadButton({super.key,
    required this.songFilePath,
    required this.songName});

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
              color: Colors.grey,);
          }
          else if(state.status.isLoading ){
            return SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          else if(state.status.isSuccess){
            return Icon(Icons.download_sharp,
              color: Colors.grey);
          }
          else if(state.status.isError){
            return Icon(Icons.download_sharp,
              color: Colors.grey);
          }
          return Container(width: 5,height: 5,color: Colors.black,);
    })
        //
    );
  }

}
