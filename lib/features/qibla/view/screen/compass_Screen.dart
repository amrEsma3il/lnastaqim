import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../../../core/constants/images.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  double? _qiblahDirection;
  Position? _position;

  @override
  void initState() {
    super.initState();
    _initializeQiblah();
  }

  Future<void> _initializeQiblah() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    _position = await Geolocator.getCurrentPosition();
    _qiblahDirection = _calculateQiblahDirection(_position!);
    setState(() {});
  }

  double _calculateQiblahDirection(Position position) {
    const kaabaLat = 21.4225;
    const kaabaLng = 39.8262;

    final userLatRad = position.latitude * pi / 180;
    final userLngRad = position.longitude * pi / 180;
    final kaabaLatRad = kaabaLat * pi / 180;
    final kaabaLngRad = kaabaLng * pi / 180;

    final deltaLng = kaabaLngRad - userLngRad;
    final x = sin(deltaLng);
    final y = cos(userLatRad) * tan(kaabaLatRad) - sin(userLatRad) * cos(deltaLng);

    double direction = atan2(x, y) * 180 / pi;
    return (direction + 360) % 360;
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('d MMMM yyyy', 'ar').format(DateTime.now());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// ✅ خلفية التصميم الزخرفي
            Positioned.fill(
              child: Padding(
             padding:  EdgeInsets.only(right: 2.5.w),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.backgroundQibla,), // لازم تضيف صورة الإطار
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 146.h),
                  Text(
                    'اتجاه القبلة',
                    style: TextStyle(
                      fontFamily: 'Thuluth',
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
               
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 25.sp,
                              fontFamily: 'Thuluth',
                      color: AppColor.black,
                    ),
                  ),
                  SizedBox(height: 50.h),

                  /// ✅ بوصلة
                  if (_qiblahDirection == null)
                    SizedBox(
                      height: 300.h,
                  child: Center(child: const CircularProgressIndicator()))
                  else
                    StreamBuilder<CompassEvent>(
                      stream: FlutterCompass.events,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final direction = snapshot.data!.heading ?? 0;
                        final angle = ((_qiblahDirection! - direction) % 360);

                        return Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                // دائرة البوصلة (ثابتة)
                                Image.asset(
                                  'assets/images/quiblahCompass.png', // صورة دائرية بدون سهم
                                  width: 220.w,
                                  height: 220.h,
                                ),

                                // السهم الدوار
                                Transform.rotate(
                                  angle: angle * (pi / 180),
                                  child: Image.asset(
                                    'assets/images/neelde.png', // سهم القبلة
                                    width: 100.w,
                                    height: 100.h,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 105.h),
                            Text(
                              angle.toInt().toString().toArabic,
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                            ),
                        
                            Text(
                              'الاتجاه التقريبي للقبلة\nفي الإباجية ${angle.toInt()}'.toArabic,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.7.sp,
                                color: AppColor.blueBlack,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),

            /// زر رجوع
            Positioned(
              top: 12.h,
              right: 13.w,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back, color: AppColor.primary, size: 28.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
