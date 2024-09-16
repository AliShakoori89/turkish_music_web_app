import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadRepository{

  late String _localPath;

  downloadFile(String songFile, String songName, TargetPlatform platform) async {
    await _prepareSaveDir(platform);
    try {
      await Dio().download(songFile,
          _localPath + "/" + "${songName}.mp3");


    } catch (e) {

    }
  }

  Future<void> _prepareSaveDir(TargetPlatform platform) async {
    _localPath = (await _findLocalPath(platform))!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  ///sdcard/Music/"${songName}.mp3"

  Future<String?> _findLocalPath(TargetPlatform platform) async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/Music/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

}