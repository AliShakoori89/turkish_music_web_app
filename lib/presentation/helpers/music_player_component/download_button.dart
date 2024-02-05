import 'package:flutter/material.dart';

class DownloadButton extends StatefulWidget {

  const DownloadButton({super.key});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {

  bool download = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
          onTap: () {

          },
          child: Icon(
            Icons.download,
            size: 15.0, color:
          Colors.grey,)
        ));
  }
}
