import 'dart:async';

import 'package:get/get.dart';

import '../../../../config/routing/app_routes_info/app_routes_name.dart';


class SplashCubit {
 
late Timer time;

void splashTimerEvent(){
time=Timer(const Duration(seconds: 6), () async {



    Get.offAllNamed(AppRouteName.layout);
 

});


 }
   
}