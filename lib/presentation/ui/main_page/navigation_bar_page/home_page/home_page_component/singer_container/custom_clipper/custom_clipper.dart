import 'package:flutter/material.dart';

class MyClipper  extends CustomClipper<Path> {
  @override
  getClip(Size size) {
  var path = Path();
  path.moveTo(0, size.height * 0.2);
  path.lineTo(0, size.height * 0.8);
  path.quadraticBezierTo(0, size.height, size.width / 4 * 0.1, size.height);
  path.lineTo(size.width / 4 * 0.7 - 10, size.height);
  path.quadraticBezierTo(
      size.width / 4 * 0.7, size.height, size.width / 4 * 0.7, size.height * 0.95);
  path.quadraticBezierTo(size.width / 4 * 0.7, size.height * 0.30,
      size.width / 4 - 10, size.height * 0.3);
  path.quadraticBezierTo(
      size.width / 4, size.height * 0.3, size.width / 4, size.height * 0.3 - 10);
  path.lineTo(size.width / 4, size.height * 0.2);
  path.quadraticBezierTo(size.width / 4, 0, size.width / 4 * 0.9, 0);
  path.lineTo(size.width / 4 * 0.1, 0);
  path.quadraticBezierTo(0, 0, 0, size.height * 0.2);
  return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}