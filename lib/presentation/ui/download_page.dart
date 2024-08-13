import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Download"),
          centerTitle: true,
        ),
      body: ElevatedButton(
          onPressed: (){
            showFile();
          },
          child: Text("aaaaaaa")),
    );
  }

  Future showFile() async{
    print("0000000000000000000");
    final String dir = (await getTemporaryDirectory()).path;
    print("1111111111111111111111");
//Use the path to launch the directory with the native file explorer
    var a = await OpenFile.open("/storage/emulated/0/Download/");
    print(a.message);
  }


}
