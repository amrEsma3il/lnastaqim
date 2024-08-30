import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../widgets/surah_controls_widget.dart';
import '../widgets/surah_info_widget.dart';
import '../widgets/surah_slider_widget.dart';


class SurahPlayerScreen extends StatelessWidget {
  const SurahPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SurahPlayerCubit(),
      child: SafeArea(
        child: Scaffold(
             
          body:  Container(
            decoration: const BoxDecoration(color: AppColor.blueColor),
            padding: const EdgeInsets.fromLTRB(8,9,8,16),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: Get.width,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(onPressed: () {
                    
                                    }, icon:  Icon(Icons.arrow_back,color: AppColor.lightBlue,size: 28,)),
                  ),
                    
                 Row(children: [   IconButton(onPressed: () {
                  
                }, icon:  Icon(Icons.music_note_outlined,color: AppColor.lightBlue,size: 26,)),
                IconButton(onPressed: () {
                  
                }, icon:  Icon(Icons.favorite,color: AppColor.lightBlue,size: 26,))],)
                ],),
                   const SizedBox(height: 8),
                const SurahInfoWidget(),
                const SizedBox(height: 20),
                const SurahSliderWidget(),
                         const SizedBox(height: 17),
                const SurahControlsWidget(),
             
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
