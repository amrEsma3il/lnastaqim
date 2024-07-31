import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import '../../../../core/utilits/extensions/arabic_numbers.dart';

import '../../../../core/utilits/functions/check.dart';
import '../quran/quran_cubit.dart';

class ScreenOverlayCubit extends Cubit<int> {
  ScreenOverlayCubit() : super(0);
  static ScreenOverlayCubit get(BuildContext context) =>
      BlocProvider.of<ScreenOverlayCubit>(context);
// final QuranCubit quranCubit= QuranCubit();
  Timer? _debounce;
  TextEditingController fastMove = TextEditingController();
  TextEditingController surahName = TextEditingController();
  TextEditingController pageNum = TextEditingController();

  List<Map<String, dynamic>> menuItems(BuildContext context) => [
        {
          "text": "انتقال سريع",
          "onTap": () {
            emit(1);
            showPageDialog(context);
          }
        },
        {
          "text": "الاعدادات",
          "onTap": () {
            // implement dialog here
          }
        },
        {
          "text": "مساعدة",
          "onTap": () {
            // implement dialog here
          }
        },
        {
          "text": "من نحن",
          "onTap": () {
            // implement dialog here
          }
        }
      ];

  overlaysVisability() {
    if (state == 0 || state == 2) {
      emit(1);
    } else {
      emit(0);
    }

//  quranCubit.stream.listen((ayaState) {
//       // React to changes in FirstCubit's state
//   if (ayaState.offset.dx==0&&ayaState.offset.dy==0
// ) {
//   if (state==0||state==1) {
//     emit(state);
// }
// }
//     });
  }

  menuShow() {
    emit(2);
  }

  keepOverlayState(int state) {
    emit(state);
  }

  showPageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.blueColor.withOpacity(0.89),
          contentPadding: const EdgeInsets.all(20),
          title: const Text(
            'انتقال سريع',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.right,
          ),
          content: SizedBox(
            width: (Get.width),
            height: Get.height / 4 * 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                const Text(
                  " أدخل رقم الصفحة او اسم السورة",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 7.h),
                TextFormField(
                  controller: fastMove,
                  textAlign: TextAlign.right,
                  // keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    hintText: '١',
                    hintStyle: TextStyle(color: Colors.white60),
                  ),
                  onChanged: (value) {

                    // onChangedDebounced(value,context);
                    bool isPage = isNumeric(value);
                    fastMove.text = value.toArabic;
                    
                    if (isPage) {
                    
                      pageNum.text = value.toArabic;
                      String surahNameText = QuranCubit.get(context)
                          .getSurahNameFromPage(int.parse(value) - 1);
                      int surahNumberText = QuranCubit.get(context)
                          .getSurahNumberFromPage(int.parse(value) - 1);
                      surahName.text =
                          "${surahNumberText.toString().toArabic}.$surahNameText";
                    } else {
                      int? surahNumberText =
                          QuranCubit.get(context).getSurahNumber(value);
                      int? pageNumberText =
                          QuranCubit.get(context).getSurahStartPage(value);
                      if (surahNumberText != null && pageNumberText != null) {
                        pageNum.text = pageNumberText.toString().toArabic;
                        surahName.text =
                            "${surahNumberText.toString().toArabic}.${value.toString()}";
                      }
                    }
                  },
                ),
                const SizedBox(height: 22),
                const Text(
                  'انتقال سريع',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      controller: surahName,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxWidth: 180.w),
                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        hintText: '١. الفاتحة',
                        hintStyle: const TextStyle(color: Colors.white60),
                      ),
                    ),
                    TextFormField(
                      controller: pageNum,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                        constraints: BoxConstraints(maxWidth: 55.w),
                        hintText: '١',
                        hintStyle: const TextStyle(color: Colors.white60),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                int pageIndex = 604 - int.parse(pageNum.text.toEnglish);
                pageIndex = pageIndex > 604 ? 604 : pageIndex;
                Navigator.of(context).pop();
                fastMove.text = "";
                surahName.text = "";
                pageNum.text = "";
                emit(0);
                QuranCubit.get(context).pageController.jumpToPage(pageIndex);
              },
              child: const Text(
                'موافق',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void onChangedDebounced(String value,BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      performHeavyComputation(value,context);
    });
  }




    Future<void> performHeavyComputation(String value,BuildContext context) async {
    bool isPage = isNumeric(value);
    fastMove.text = value.toArabic; // Assuming toArabic() is an extension method
    if (isPage) {
      pageNum.text = value.toArabic; // Assuming toArabic() is an extension method
      final result = await compute(_heavyComputationForPage,{"page":int.parse(value) - 1,"context":context});
      surahName.text = "${result!['surahNumberText']}.${result['surahNameText']}";
    } else {
      final result = await compute(_heavyComputationForSurah, {"surah": value,"context":context});
      if (result != null) {
        pageNum.text = result['pageNumberText'].toString().toArabic; // Assuming toArabic() is an extension method
        surahName.text = "${result['surahNumberText'].toString().toArabic}.$value"; // Assuming toArabic() is an extension method
      }
    }
  }


  static Map<String, dynamic>? _heavyComputationForPage(Map<String, dynamic> args) {
    // Perform your heavy computation here
    // For example, fetching Surah name and number from a page number
    int page=args['page'];
     BuildContext context=args['context'];
    final surahNameText = QuranCubit.get(context).getSurahNameFromPage(page);
    final surahNumberText = QuranCubit.get(context).getSurahNumberFromPage(page);
    return {'surahNameText': surahNameText, 'surahNumberText': surahNumberText};
  }

  static Map<String, dynamic>? _heavyComputationForSurah(Map<String, dynamic> args) {
    // Perform your heavy computation here
    // For example, fetching Surah number and start page from Surah name
    String surah=args['surah'];
     BuildContext context=args['context'];
    final surahNumberText = QuranCubit.get(context).getSurahNumber(surah);
    final pageNumberText = QuranCubit.get(context).getSurahStartPage(surah);
    if (surahNumberText != null && pageNumberText != null) {
      return {'surahNumberText': surahNumberText, 'pageNumberText': pageNumberText};
    }
    return null;
  }
}
