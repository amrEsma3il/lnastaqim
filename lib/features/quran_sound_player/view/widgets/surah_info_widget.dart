import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';

// import '../../../../core/constants/images.dart';
class SurahInfoWidget extends StatelessWidget {
  const SurahInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: Get.width-50,
      height: 350.h,
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(35),
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage('assets/images/reciter_10.png'),
          fit: BoxFit.cover,
         
        ),
      ),
    
    );
  }
}
