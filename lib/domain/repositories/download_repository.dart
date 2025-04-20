import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../main.dart';

class DownloadRepository {
  late String _localPath;

  Future<void> downloadFile(String songFile, String songName, TargetPlatform platform) async {
    await _prepareSaveDir(platform);

    try {
      final filePath = p.join(_localPath, "$songName.mp3");

      await Dio().download(
        songFile,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('Downloading: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );

      await showNotification('Download Complete', 'Your file has been downloaded.');
    } catch (e) {
      print('Download failed: $e');
    }
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Notifications for completed downloads',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  Future<void> _prepareSaveDir(TargetPlatform platform) async {
    final path = await _findLocalPath(platform);
    if (path == null) {
      print('Download path is not available on this platform.');
      return;
    }

    _localPath = path;

    final savedDir = Directory(_localPath);
    if (!await savedDir.exists()) {
      await savedDir.create(recursive: true);
    }
  }

  Future<String?> _findLocalPath(TargetPlatform platform) async {
    return null;
  }
}
