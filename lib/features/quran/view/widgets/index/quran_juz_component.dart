
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../bussniess_logic/quran/index_cubit/index_cubit.dart';
import 'quran_hizb_component.dart';

class JuzComponent extends StatelessWidget {
 final int parentIndex;
  const JuzComponent({
    super.key, required this.parentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width ,
      child: Column(
        children: [
                                            // SizedBox(width: Get.width,),
      
        Text("الجزء ${IndexCubit.juzArabicWord(IndexCubit.getQuranJuz()[parentIndex].juz)}",style: const TextStyle(color: Colors.white,fontSize: 19)),
        const SizedBox(height: 15,),
      
        SizedBox(width: Get.width,
          child: Column(children: List.generate(IndexCubit.getQuranJuz()[parentIndex].verses.length, (verseIndex) =>QuranHizpComponent(hizp: IndexCubit.getQuranJuz()[parentIndex].verses[verseIndex],) ),))
      ],),
    );
  }
}
