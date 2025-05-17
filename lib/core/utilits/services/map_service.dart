import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

import '../../../main.dart';
import 'url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openGoogleMapsForMosques() async {
    // التأكد من الأذونات
    

    // الحصول على الموقع الحالي
    Position currentPosition =position!;

log(currentPosition.latitude.toString());
log(currentPosition.longitude.toString());

    // إنشاء رابط البحث في Google Maps
    String latitude = currentPosition.latitude.toString();
    String longitude = currentPosition.longitude.toString();
      //  String query = Uri.encodeComponent("Mosque");

    String googMapleUrl =
    "https://www.google.com/maps/search/Mosque/@$latitude,$longitude,15z";


    // فتح الرابط
   UrlLauncher.launchToUrl(googMapleUrl);
  }
}
