import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class QuiblahScreen extends StatelessWidget {
  const QuiblahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Column(
        children: [
          GestureDetector(
            onTap: ()async
            {
              PermissionStatus locationstatus =
                          await Permission.location.request();
                      if (locationstatus == PermissionStatus.granted) {}
                      if (locationstatus == PermissionStatus.denied) {
                        const SnackBar(
                          content: Text('This premission is recommended'),
                        );
                      }
                      if (locationstatus ==
                          PermissionStatus.permanentlyDenied) {
                        openAppSettings();
                      }
            },
            child: const Text(
              'Get Current Position'
            ),
          ),
        ],
        ),
         ),
    );
  }
}