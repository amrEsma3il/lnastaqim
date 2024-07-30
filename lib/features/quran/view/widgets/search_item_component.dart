import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import 'package:lnastaqim/features/quran/bussniess_logic/quran/quran_cubit.dart';

import '../../../../core/constants/colors.dart';
import '../../bussniess_logic/quran_sowar/search_on_aya_from_whole_quran_cubit.dart';
import '../../bussniess_logic/screen_tap_Visibility/screen_tap_visability.dart';
import '../../data/models/search_ayah_entity.dart';

class SearchItemComponent extends StatelessWidget {
  const SearchItemComponent({super.key, required this.ayaInfo, required this.searchWordLength});
  final SearchAyahEntity ayaInfo;
  final int searchWordLength;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //close overlay then mavigate to page then mark aya
        SearchOnAyaCubit.get(context).clearSearchEvent();
             ScreenOverlayCubit.get(context).overlaysVisability();
             QuranCubit.get(context).pageController.jumpToPage(604-ayaInfo.aya.page);//searchAya
  QuranCubit.get(context).searchAya(ayaInfo.aya.ayahUQNumber);
      },
      child: Container(padding: EdgeInsets.fromLTRB(11.w, 11.h, 13.w, 8.h),
        height: 118.h,
      width: Get.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(textAlign: TextAlign.center,
              maxLines: 2,
              
              overflow: TextOverflow.ellipsis,
                   textDirection: TextDirection.rtl,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  height: 1.2.h,
                  wordSpacing: 2.8,
                  fontSize: 21,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Majeed', 
                      
                ),
                children:  [
                  TextSpan(
                    text:ayaInfo.aya.ayaTextEmlaey.substring(0, ayaInfo.startPosition),
                    // style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  TextSpan(
                    text:ayaInfo.aya.ayaTextEmlaey.substring(ayaInfo.startPosition,ayaInfo.startPosition+searchWordLength) ,
                    style: TextStyle(
                        color:AppColor.yellow1,
                        fontSize: 18,
                       fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text:ayaInfo.aya.ayaTextEmlaey.substring(ayaInfo.startPosition+searchWordLength, ayaInfo.aya.ayaTextEmlaey.length) ,
                    // style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
      
            SizedBox(height: 8.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                    
                  Text("الاية رقم ${ayaInfo.aya.ayahNumber}".toArabic,style:  
                  const TextStyle(color:Colors.white70,fontSize: 14,fontWeight: FontWeight.w600),),
                  
                  Text(QuranCubit.get(context).getSurahNameFromAyah(ayaInfo.aya),style:  const TextStyle(color:Colors.white70,fontSize: 14,fontWeight: FontWeight.w600),)
                ],),
            )
          ],
        ),
      ),
    );
  }
}
