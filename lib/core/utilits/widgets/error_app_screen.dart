import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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

class PermissionErrorScreen extends StatefulWidget {
  final String errorMessage;
  final Future<void> Function()? onRetry;

  const PermissionErrorScreen({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PermissionErrorScreenState createState() => _PermissionErrorScreenState();
}

class _PermissionErrorScreenState extends State<PermissionErrorScreen> {
  bool _isLoading = false;

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
                        color: Colors.black12.withValues(alpha:  0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.errorMessage.contains('الإشعارات')
                        ? Icons.notifications_off
                        : Icons.location_off,
                    size: 66,
                    color: const Color(0xFF37517E),
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
                // رسالة الخطأ
                Text(
                  widget.errorMessage.replaceAll("Exception", "خطأ"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Amiri',
                    height: 1.7,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 28),
                // زر إعادة المحاولة أو فتح الإعدادات
                ElevatedButton.icon(
                  icon: _isLoading
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
                    _isLoading
                        ? 'جاري المعالجة...'
                        : widget.errorMessage.contains('دائم')
                            ? 'افتح الإعدادات'
                            : 'السماح للصلاحيات',
                    style: const TextStyle(
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
                  onPressed: _isLoading
                      ? null // Disable button during loading
                      : () async {
                          setState(() {
                            _isLoading = true;
                          });
                          log('Retry button pressed');
                          if (widget.errorMessage.contains('دائم')) {
                            log('Opening location settings');
                            await openAppSettings().then((_) async {
                              if (widget.onRetry != null) {
                                log('Executing onRetry callback after settings');
                                await widget.onRetry!();
                              }
                            });
                          } else {
                            if (widget.onRetry != null) {
                              log('Executing onRetry callback');
                              await widget.onRetry!();
                            }
                          }
                          // Keep loading until navigation is complete
                          // setState(() {
                          //   _isLoading = false;
                          // });
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