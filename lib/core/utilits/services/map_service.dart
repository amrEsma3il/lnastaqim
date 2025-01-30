import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

import '../../../main.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openGoogleMapsForMosques() async {
    // التأكد من الأذونات
    

    // الحصول على الموقع الحالي
    Position currentPosition = position!;

log(currentPosition.latitude.toString());
log(currentPosition.longitude.toString());

    // إنشاء رابط البحث في Google Maps
    String latitude = currentPosition.latitude.toString();
    String longitude = currentPosition.longitude.toString();
      //  String query = Uri.encodeComponent("Mosque");

    String googleUrl =
    "https://www.google.com/maps/search/Mosque/@$latitude,$longitude,15z";


    // فتح الرابط
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open Google Maps.';
    }
  }
}
