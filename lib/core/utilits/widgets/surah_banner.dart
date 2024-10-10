import 'package:flutter/material.dart';

class LPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(228, 148, 114, 196)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0007074, size.height * -0.0013200);
    path_0.lineTo(size.width * -0.0009222, size.height * 0.9896250);
    path_0.lineTo(size.width * 0.7385185, size.height * 0.9998450);
    path_0.lineTo(size.width * 0.5235852, size.height * 0.5013500);
    path_0.lineTo(size.width * 0.7381963, size.height * 0.0001000);
    path_0.lineTo(size.width * 0.0007074, size.height * -0.0013200);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

<<<<<<< HEAD
    // Layer 1

    Paint paintStroke0 = Paint()
=======
  // Layer 1
  
  Paint paintStroke0 = Paint()
>>>>>>> fd77e0de39d3798a5be8e84be1846b2936ad0af0
      ..color = const Color.fromARGB(146, 168, 125, 206)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
<<<<<<< HEAD

    canvas.drawPath(path_0, paintStroke0);
=======
     
         
    
    canvas.drawPath(path_0, paintStroke0);
  
    
>>>>>>> fd77e0de39d3798a5be8e84be1846b2936ad0af0
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill1 = Paint()
      ..color = const Color.fromARGB(228, 148, 114, 196)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9992926, size.height * -0.0013200);
    path_0.lineTo(size.width * 1.0009222, size.height * 0.9896250);
    path_0.lineTo(size.width * 0.2614815, size.height * 0.9998450);
    path_0.lineTo(size.width * 0.4764148, size.height * 0.5013500);
    path_0.lineTo(size.width * 0.2618037, size.height * 0.0001000);
    path_0.lineTo(size.width * 0.9992926, size.height * -0.0013200);
    path_0.close();

    canvas.drawPath(path_0, paintFill1);

<<<<<<< HEAD
    // Layer 1

    Paint paintStroke0 = Paint()
=======
  // Layer 1
  
  Paint paintStroke0 = Paint()
>>>>>>> fd77e0de39d3798a5be8e84be1846b2936ad0af0
      ..color = const Color.fromARGB(146, 168, 125, 206)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
<<<<<<< HEAD

    canvas.drawPath(path_0, paintStroke0);
=======
     
         
    
    canvas.drawPath(path_0, paintStroke0);
  
    
>>>>>>> fd77e0de39d3798a5be8e84be1846b2936ad0af0
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
