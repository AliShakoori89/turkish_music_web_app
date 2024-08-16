import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {

  var _openResult = 'Unknown';

  @override
  void initState() {
    showFile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Download"),
          centerTitle: true,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('open result: $_openResult\n'),
            TextButton(
              child: Text('Tap to open file'),
              onPressed: (){
                isDenied();
              },
            ),
          ],
        ),
      ),
    );
  }

  isDenied() async {
    if (await Permission.storage.isPermanentlyDenied) {
      // The permission is permanently denied, and the user should be directed to the app settings.
      openAppSettings();
    }else{
      _openOtherAppFile();
    }
  }

  showFile(context) async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // Request the permission
      if (await Permission.storage.request().isGranted) {
        // The permission is granted
        print("Permission Granted");
      } else {
        // The permission is denied
        print("Permission Denied");
      }
    } else if (status.isGranted) {
      // The permission is already granted
      print("Permission Already Granted");
    }
  }

  _openOtherAppFile() async {
    //open an external storage image file on android 13
    if (await Permission.audio.request().isGranted) {
      final result = await OpenFile.open("/storage/emulated/0/Download/Can Hatice.mp3");
      setState(() {
        _openResult = "type=${result.type}  message=${result.message}";
      });
    }
  }
}
