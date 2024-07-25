import 'package:flutter/widgets.dart';
import 'package:kids_lms_project/constants/colors.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = MyAppColors.darkGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(
        size.height / 6, size.width * 0.5, size.height * 0.8, size.width * 0.9);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyPainter_reverse extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = MyAppColors.darkGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(
        size.height / 6, size.width * 0.5, size.height * 0.8, size.width * 0.9);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
