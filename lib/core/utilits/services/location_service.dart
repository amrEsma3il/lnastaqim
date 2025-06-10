import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService {
  static Future<Position?> determinePosition() async {
    // التحقق من تفعيل خدمات الموقع
    if (!await Geolocator.isLocationServiceEnabled()) {
      // عرض رسالة للمستخدم مع خيار لفتح الإعدادات
      await _showLocationServicesDialog(Get.context!);
      return null; // الرجوع بدون موقع
    }

    // التحقق من الأذونات
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await _showPermissionDeniedDialog(Get.context!);
      return null;
    }

    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('تم رفض أذونات الوصول للموقع.')),
      );
      return null;
    }

    // الحصول على الموقع الحالي
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      return position;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء محاولة الحصول على الموقع: $e')),
      );
      return null;
    }
  }

  static Future<void> _showLocationServicesDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('خدمات الموقع غير مفعلة'),
        content: Text('يرجى تفعيل خدمات الموقع لاستخدام هذه الميزة.'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Geolocator.openLocationSettings(); // يفتح إعدادات الموقع
            },
            child: Text('فتح الإعدادات'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('إلغاء'),
          ),
        ],
      ),
    );
  }

  static Future<void> _showPermissionDeniedDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('أذونات الموقع مرفوضة نهائياً'),
        content: Text(
            'لقد رفضت أذونات الموقع بشكل دائم. يرجى تفعيل الأذونات من إعدادات التطبيق.'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Geolocator.openAppSettings(); // يفتح إعدادات التطبيق
            },
            child: Text('فتح الإعدادات'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('إلغاء'),
          ),
        ],
      ),
    );
  }
}
