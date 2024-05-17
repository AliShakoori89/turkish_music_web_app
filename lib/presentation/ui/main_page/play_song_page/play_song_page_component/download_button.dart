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

  late final String path;
  late DownloaderUtils options;
  late DownloaderCore core;

  List<FileModel> fileList = [];

  @override
  void initState() {
    super.initState();

    initPlatformState();
    generateFileList();
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  generateFileList() {
    fileList
      ..add(FileModel(
        fileName: widget.songName,
        url: widget.songFilePath,
        progress: 0.0,
      ));
  }

  void _setPath() async {
    Directory _path = await getApplicationDocumentsDirectory();

    String _localPath = _path.path + Platform.pathSeparator + 'Download';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    print("%%%%%%%%%%%%%%%%%                              "+_localPath);

    path = _localPath;
  }

  generateWidgetList() {
    List<Widget> widgetList = [];

    fileList.asMap().forEach((index, element) {
      widgetList.add(Row(
        children: [
          Container(
            width: 200,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(fileList[index].fileName!),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            onPressed: () async {
              options = DownloaderUtils(
                progressCallback: (current, total) {
                  final progress = (current / total) * 100;
                  print('Downloading: $progress');

                  setState(() {
                    fileList[index].progress = (current / total);
                  });
                },
                file: File('$path/${fileList[index].fileName}'),
                progress: ProgressImplementation(),
                onDone: () {
                  setState(() {
                    fileList[index].progress = 0.0;
                  });
                  OpenFile.open('$path/${fileList[index].fileName}')
                      .then((value) {
                    // delete the file.
                    File f = File('$path/${fileList[index].fileName}');
                    f.delete();
                  });
                },
                deleteOnCancel: true,
                accessToken: '',
              );
              core = await Flowder.download(
                fileList[index].url!,
                options,
              );
            },
            child: Column(
              children: [
                if (fileList[index].progress == 0.0)
                  Icon(
                    Icons.download,
                  ),
                if (fileList[index].progress != 0.0)
                  LinearPercentIndicator(
                    width: 100.0,
                    lineHeight: 14.0,
                    percent: fileList[index].progress!,
                    backgroundColor: Colors.blue,
                    progressColor: Colors.white,
                  ),
              ],
            ),
          ),
        ],
      ));
    });

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            ...generateWidgetList(),
          ],
        ));
  }
}
