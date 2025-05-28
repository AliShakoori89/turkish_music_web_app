import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';

Widget? buildBackButtonIfIosWeb() {
  if (kIsWeb) {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    // if (userAgent.contains('iphone') || userAgent.contains('ipad')) {
      return IconButton(
        icon: Icon(Icons.arrow_back_ios_new_sharp),
        onPressed: () {
          html.window.history.back();
        },
      );
    // }
  }
  return null;
}