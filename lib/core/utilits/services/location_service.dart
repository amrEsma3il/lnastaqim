import 'dart:developer' as dev;

import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> determinePosition() async {
    // Check if location services are enabled
 {
   
         LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }



     if (permission == LocationPermission.deniedForever) {
      dev.log('Location permission is denied forever');
      throw Exception(
        'تم رفض صلاحيات الوصول للموقع بشكل دائم. يرجى تفعيلها من إعدادات التطبيق.',
      );
    }

    if (permission == LocationPermission.denied) {
      throw Exception('تم رفض صلاحيات الوصول للموقع.');
    }

    }  // Check permissions


    // Get current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: 200,
        ),
      );
      return position;
    } catch (e) {
      throw Exception('حدث خطأ أثناء محاولة الحصول على الموقع: $e');
    }
  }
}
