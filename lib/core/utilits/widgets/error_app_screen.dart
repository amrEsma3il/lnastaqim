import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer';

class ErrorApp extends StatelessWidget {
  final String errorMessage;
  final Future<void> Function()? onRetry;

  const ErrorApp({super.key, required this.errorMessage, this.onRetry});

  @override
  Widget build(BuildContext context) {
    log('Showing ErrorApp with message: $errorMessage');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PermissionErrorScreen(errorMessage: errorMessage, onRetry: onRetry),
    );
  }
}

class PermissionErrorScreen extends StatelessWidget {
  final String errorMessage;
  final Future<void> Function()? onRetry;

  const PermissionErrorScreen({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEEF2F7), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // أيقونة داخل دائرة
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    errorMessage.contains('الإشعارات')
                        ? Icons.notifications_off
                        : Icons
                            .location_off, // أو Icons.notifications_off حسب الحالة
                    size: 66,
                    color: Color(0xFF37517E),
                  ),
                ),

                const SizedBox(height: 28),

                // العنوان
                const Text(
                  'لم نتمكن من المتابعة',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Amiri',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF37517E),
                  ),
                ),

                const SizedBox(height: 16),

                // رسالة الخطأ من المتغير
                Text(
                  errorMessage.replaceAll("Exception", "خطأ"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Amiri',
                    height: 1.7,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 28),

                // زر المحاولة مجددًا
                ElevatedButton.icon(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  label: Text(
                    errorMessage.contains('خدمات')
                        ? 'افتح الإعدادات'
                        : "السماح للصلاحيات",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Amiri',
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF37517E),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    log('Retry button pressed');
                    if (errorMessage.contains('خدمات')) {
                      log('Opening location settings');
               
                       LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
          
                    }
                    if (onRetry != null) {
                      log('Executing onRetry callback');
                      await onRetry!();
                    }
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  '▬▬▬▬ ❖ ▬▬▬▬',
                  style: TextStyle(fontSize: 18, color: Color(0xFF37517E)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
