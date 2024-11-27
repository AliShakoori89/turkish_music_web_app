import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

import '../../main.dart';

class DownloadRepository{

  late String _localPath;

  downloadFile(String songFile, String songName, TargetPlatform platform) async {
    await _prepareSaveDir(platform);
    try {
      await Dio().download(
          songFile,
          _localPath + "/" + "${songName}.mp3",
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('Downloading: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },);
      await showNotification('Download Complete', 'Your file has been downloaded.');

    } catch (e) {
      print('Download failed: $e');
    }
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'download_channel', // Channel ID
      'Downloads', // Channel Name
      channelDescription: 'Notifications for completed downloads',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      notificationDetails,
    );
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