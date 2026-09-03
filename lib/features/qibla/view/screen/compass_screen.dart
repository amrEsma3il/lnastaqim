import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
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
  String? _localityName;

  @override
  void initState() {
    super.initState();
    _initializeQiblah();
  }
Future<void> _initializeQiblah() async {
 
  final permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
   Get.back();
    return;
  }

  dev.log('Initializing qiblah...');

  try {
    _position = await Geolocator.getCurrentPosition();
  } catch (e) {
    dev.log("Error getting position: $e");
    Get.back();
    return;
  }

  _qiblahDirection = _calculateQiblahDirection(_position!);

try {
  final url = Uri.parse(
    'https://nominatim.openstreetmap.org/reverse?lat=${_position!.latitude}&lon=${_position!.longitude}&format=json&accept-language=ar',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final address = data['address'];

    _localityName = address['city'] ??
        address['town'] ??
        address['village'] ??
        address['municipality'] ??
        address['county'] ??
        address['state_district'] ??
        address['state'] ??
        "موقعك";
  } else {
    _localityName = "موقعك";
  }
} catch (e) {
  dev.log("Error getting locality: $e");
  _localityName = "موقعك";
}


  setState(() {});
}

double _calculateQiblahDirection(Position position) {
  const kaabaLat = 21.4225;
  const kaabaLng = 39.8262;

  final latRad = position.latitude * pi / 180;
  final lngRad = position.longitude * pi / 180;
  final kaabaLatRad = kaabaLat * pi / 180;
  final kaabaLngRad = kaabaLng * pi / 180;

  final deltaLng = kaabaLngRad - lngRad;

  final x = sin(deltaLng);
  final y = cos(latRad) * tan(kaabaLatRad) - sin(latRad) * cos(deltaLng);

  double qiblaDirection = atan2(x, y) * (180 / pi);

  if (qiblaDirection < 0) {
    qiblaDirection += 360;
  }

  return qiblaDirection;
}
  void _showLocationDeniedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('الموقع مطلوب'),
        content: const Text('يجب السماح بالوصول للموقع لتحديد اتجاه القبلة.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Future.delayed(Duration(milliseconds: 200), () {
                if (mounted) Get.back(); // Exit screen
              });
            },
            child: const Text('No thanks'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              _initializeQiblah(); // Retry
            },
            child: const Text('حسنًا'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'd MMMM yyyy',
      'ar',
    ).format(DateTime.now());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(right: 2.5.w),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.backgroundQibla),
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
                  if (_qiblahDirection == null)
                    SizedBox(
                      height: 300.h,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  else
                    StreamBuilder<CompassEvent>(
                      stream: FlutterCompass.events,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            !snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final direction = snapshot.data!.heading ?? 0;
                        final angle =
                            ((_qiblahDirection! - direction) % 360);

                        return Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/quiblahCompass.png',
                                  width: 220.w,
                                  height: 220.h,
                                ),
                                Transform.rotate(
                                  angle: angle * (pi / 180),
                                  child: Image.asset(
                                    'assets/images/neelde.png',
                                    width: 100.w,
                                    height: 100.h,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 105.h),
                            Text(textAlign: TextAlign.center,
                              '${angle.toInt()}°'.toArabic,
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                            ),
                            Text(
                              'الاتجاه التقريبي للقبلة\nفي ${_localityName ?? "موقعك"}'
                                  .toArabic,
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
            Positioned(
              top: 12.h,
              right: 13.w,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColor.primary,
                  size: 28.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
