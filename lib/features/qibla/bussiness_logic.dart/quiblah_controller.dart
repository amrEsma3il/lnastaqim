import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class QuiblahCubit extends Cubit<bool> {
  QuiblahCubit(super.initialState);
  bool hasPremission = false;
 Position? currentLocation;
 double? latitude;
 double? longitude;

  Future getPremission() async {
    PermissionStatus locationstatus = await Permission.location.request();
    if (locationstatus == PermissionStatus.granted) {
      hasPremission = true;
      latitude=currentLocation!.latitude;
      longitude=currentLocation!.longitude;
      log(latitude!);
      log(longitude!);
    }
    if (locationstatus == PermissionStatus.denied) {
      const SnackBar(
        content: Text('This premission is recommended'),
      );
    }
    if (locationstatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
      hasPremission = true;
    }
  }
}
