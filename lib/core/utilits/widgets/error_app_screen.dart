import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';

class ErrorApp extends StatelessWidget {
  final String errorMessage;
  final Future<void> Function()? onRetry;

  const ErrorApp({super.key, required this.errorMessage, this.onRetry});

  @override
  Widget build(BuildContext context) {
    log('Showing ErrorApp with message: $errorMessage');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ErrorAppController(),
        child: PermissionErrorScreen(
          errorMessage: errorMessage,
          onRetry: onRetry,
        ),
      ),
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
                        : Icons.location_off,
                    size: 66,
                    color: Color(0xFF37517E),
                  ),
                ),
                const SizedBox(height: 28),
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
                BlocBuilder<ErrorAppController, bool>(
                  builder: (context, state) {
                    return ElevatedButton.icon(
                      icon:
                          state
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : const Icon(Icons.settings, color: Colors.white),
                      label: Text(
                        state
                            ? 'جاري المعالجة...'
                            : errorMessage.contains('دائم')
                            ? 'افتح الإعدادات'
                            : 'السماح للصلاحيات',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Amiri',
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF37517E,
                        ), // اللون الأزرق عند التنشيط
                        disabledBackgroundColor: const Color(0xFF37517E),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed:
                          state
                              ? null
                              : () async {
                                final controller = ErrorAppController();
                                controller.changeLoading(true);
                                log('Retry button pressed');
                                try {
                                  if (errorMessage.contains('دائم')) {
                                    log('Opening location settings');
                                    await openAppSettings();
                                    if (onRetry != null) {
                                      await onRetry!();
                                    }
                                  } else if (onRetry != null) {
                                    await onRetry!();
                                  }
                                } catch (e) {
                                  log('Permission request failed: $e');
                                  controller.changeLoading(false);
                                }
                              },
                    );
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

class ErrorAppController extends Cubit<bool> {
  // Singleton instance
  static final ErrorAppController _instance = ErrorAppController._internal(
    false,
  );

  // Private constructor with initial state
  ErrorAppController._internal(super.initialState);

  // Factory constructor to return the singleton instance
  factory ErrorAppController() => _instance;

  // Method to change loading state
  void changeLoading(bool value) {
    emit(value);
  }
}
