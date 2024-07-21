import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class DownloadRepository{

  late String _localPath;

  downloadFile(String songFile, String songName, TargetPlatform platform) async {
    await _prepareSaveDir(platform);
    try {
      await Dio().download(songFile,
          _localPath + "/" + "${songName}.mp3");

      Get.showSnackbar(
        GetSnackBar(
          messageText: Text("Download Successfully."),
          icon: Icon(Icons.done),
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        ),
      );
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          messageText: Text("Download Successfully."),
          icon: Icon(Icons.close),
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        ),
      );
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

  Future<String?> _findLocalPath(TargetPlatform platform) async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }
}