import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'config/routing/app_routingconfig/app_router_configuration.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Lnastaqim());
}

class Lnastaqim extends StatelessWidget {
  const Lnastaqim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        
        
        return GetMaterialApp(
          
         
          locale: const Locale('ar'),
          debugShowCheckedModeBanner: false,
       
          getPages: routes,
          
        
        );},
  
    );
  }
}
