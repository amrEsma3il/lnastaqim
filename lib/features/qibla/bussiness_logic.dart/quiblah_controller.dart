import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class QuiblahCubit extends Cubit<bool> {
  QuiblahCubit(super.initialState);
  bool hasPremission = false;
  Animation<double>? animation; 
  AnimationController? animationController;
  TickerProvider? tickerProvider;
  double begin=0.0;
  void switchPremission(bool premission) => emit(!hasPremission);

  Future getPremission() async {
    PermissionStatus locationstatus = await Permission.location.request();
    if (locationstatus == PermissionStatus.granted) {
      hasPremission = true;
    }
    if (locationstatus == PermissionStatus.denied) {
      const SnackBar(
        content: Text('This premission is recommended'),
      );
    }
    if (locationstatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
      hasPremission=true;
    }
  }

  void getQuiblahDirection()
  {
    animationController=AnimationController(vsync: tickerProvider!,duration:const Duration(milliseconds: 5000) );
    animation=Tween(begin: 0.0,end: 0.0).animate(animationController!);
  }
}
