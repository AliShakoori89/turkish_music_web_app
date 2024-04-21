import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
          onTap: () {

          },
          child: const Icon(
            Icons.download,
            size: 15.0, color:
          Colors.grey,)
        ));
  }
}
