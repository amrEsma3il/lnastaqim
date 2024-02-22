import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'config/routing/app_routingconfig/app_router_configuration.dart';
import 'features/quran/bussniess_logic/quran_sowar/quran_sowar_cubit.dart';
import 'features/quran/bussniess_logic/quran_sowar/search_or_not_cubit.dart';
import 'features/quran/bussniess_logic/sowra_detail/sora_details_cubit.dart';


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
      designSize: const Size(393, 852),
      builder: (context, child) {
        
        
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => QuranSowarCubit()..getAllQuranSowar(), 
            ),
              BlocProvider(
              create: (context) => SearchOrNot(), 
            ),
             BlocProvider(
              create: (context) => QuranSowarVersusCubit(), 
            ),
          ],
      
        
          child: GetMaterialApp(
            
           
            locale: const Locale('ar'),
            debugShowCheckedModeBanner: false,
                 
            getPages: routes,
            
          
          ),
        );},
  
    );
  }
}
