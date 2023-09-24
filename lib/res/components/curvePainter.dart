import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyCustomCLipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 1.5);
    path.cubicTo(size.width / 2, 2 * (size.height / 2), 2 * (size.width / 2),
        size.height / 2, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    return path;
  }
  /*void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(0,size.height/2);
    path.cubicTo(size.width/4, 3 * (size.height/2), 3 * (size.width/4), size.height/2, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);

    /*var paint = Paint();
    paint.color = Color.fromRGBO(40, 67, 99, 1);*/

    path.moveTo(0, size.height * 0.8);

    //path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height * 0.8);
    canvas.drawPath(path, paint);
  }*/

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
