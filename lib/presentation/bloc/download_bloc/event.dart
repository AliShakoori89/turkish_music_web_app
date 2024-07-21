import 'package:flutter/cupertino.dart';

abstract class DownloadEvent {
  List<Object> get props => [];
}

class DownloadFileEvent extends DownloadEvent{

  final String songFilePath;
  final String songName;
  final TargetPlatform platform;

  DownloadFileEvent({required this.songFilePath, required this.songName, required this.platform});

  @override
  List<Object> get props => [songFilePath, songName, platform];
}