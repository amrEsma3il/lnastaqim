import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Coordinates> determinePosition() async {
    // التحقق من تفعيل خدمات الموقع
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('خدمات الموقع معطلة. يرجى تفعيلها.');
    }

    // التحقق من الأذونات
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('تم رفض أذونات الوصول للموقع بشكل دائم.');
    }

    if (permission == LocationPermission.denied) {
      throw Exception('تم رفض أذونات الوصول للموقع.');
    }

    // الحصول على الموقع الحالي
    try {

      Position position=await Geolocator.getCurrentPosition();

   Coordinates   coordinates=Coordinates(position.latitude, position.longitude);

   log(coordinates.latitude.toString());
      log(coordinates.longitude.toString());

      return coordinates;
    } catch (e) {
      throw Exception('حدث خطأ أثناء محاولة الحصول على الموقع: $e');
    }
  }
}
