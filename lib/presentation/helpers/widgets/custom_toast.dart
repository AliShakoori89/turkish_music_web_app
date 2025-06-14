import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class WebToast {
  final String title;
  final Color backgroundColor;
  final IconData icon;

  WebToast({
    required this.title,
    this.backgroundColor = Colors.green,
    this.icon = Icons.check_circle,
  });

  void show(BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: backgroundColor,
      icon: Icon(icon, color: Colors.white),
      messageText: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
