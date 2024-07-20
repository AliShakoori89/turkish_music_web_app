import 'dart:io';
import 'dart:typed_data';
import 'package:flowder_ex/flowder_ex.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../data/model/file_model.dart';
import '../../../../../permision_type.dart';
import '../../../../../request_permission_manager.dart';

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

  Future<String> getFilePath(String filename) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return join(appDocPath, filename);
  }

  Future<void> saveFileLocally(String filename, List<int> bytes) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, filename);
    File file = File(path);
    await file.writeAsBytes(bytes);
    print("File saved at $path");
  }

  Future<String> getApplicationDocumentsPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> createAndWriteFile(String fileName, String content) async {
    final path = await getApplicationDocumentsPath();
    final file = File('$path/$fileName');
    return file.writeAsString(content);
  }

  Future<File> writeTextFile(String fileName, String content) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);

    // Write the file
    return file.writeAsString(content);
  }


  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async{
        },
        icon: Icon(Icons.download));
  }

}
