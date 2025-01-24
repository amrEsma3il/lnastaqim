import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math' as m;
import '../../../../../core/constants/colors.dart';
import '../../../bussniess_logic/font_cubit/qurn_fonts_downlod_progress_persentage_cubit.dart';
import '../../../bussniess_logic/font_cubit/qurn_fonts_downlod_progress_persentage_state.dart';

class DiagonalStripedProgressBar extends StatelessWidget {
  final double height;

  const DiagonalStripedProgressBar({
    super.key,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // الخلفية الرمادية

        Container(
          height: height,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // شريط التقدم فقط
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.7),
                  Colors.blueAccent.withOpacity(0.6)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: BlocBuilder<FontDownloadPercentage, FontDownloadState>(
              builder: (context, state) {
                double progressWidth =
                    Get.width * (69.26 / 100) * state.percentage;
                return CustomPaint(
                  size: Size(progressWidth, height),
                  painter: _DiagonalStripedPainter(),
                );
              },
            ),
          ),
        ),
        BlocBuilder<FontDownloadPercentage, FontDownloadState>(
          builder: (context, state) {
            return Center(
              child: Text(
                "${(state.percentage * 100).toInt()}%",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.gray),
              ),
            );
          },
        ),
      ],
    );
  }
}

// رسام مخصص لإضافة الخطوط المائلة فقط للشريط المتقدم
class _DiagonalStripedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blue.withOpacity(0.7),
          Colors.blueAccent.withOpacity(0.5)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    const double stripeWidth = 14;
    const double spacing = 10;
    final double diagonal =
        m.sqrt(m.pow(size.width, 2) + m.pow(size.height, 2));

    for (double i = -diagonal; i < diagonal; i += stripeWidth + spacing) {
      final path = Path();
      path.moveTo(i, 0);
      path.lineTo(i + stripeWidth, 0);
      path.lineTo(i + stripeWidth - size.height, size.height);
      path.lineTo(i - size.height, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
