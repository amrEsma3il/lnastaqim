import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import '../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../../core/utilits/extensions/arabic_numbers.dart';
import '../../../../core/utilits/functions/check.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../../quran_sound/logic/audio_cubit/audio_cubit.dart';
import '../../view/widgets/index/quran_juz_component.dart';
import '../../view/widgets/index/quran_sora_component.dart';
import '../quran/quran_cubit.dart';
import '../quran/index_cubit/index_cubit.dart';

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
          "text": "الملاحظات",
          "onTap": () {
            emit(0);
            Get.toNamed(AppRouteName.note);
            // showMoshafNotes(context);
            //  NoteAyahListView()
          }
        },
        {
          "text": "المرجعيات",
          "onTap": () {
            emit(0);
            Get.toNamed(AppRouteName.bookmark);
          }
        },
        {
          "text": "الفهرس",
          "onTap": () {
            emit(0);
            // Get.toNamed(AppRouteName.moshafIndex);

            // implement dialog here
            showMoshafIndex(context);
          }
        },

        ///
        // {
        //   "text": "مساعدة",
        //   "onTap": () {
        //     // implement dialog here
        //   }
        // },
        // {
        //   "text": "من نحن",
        //   "onTap": () {
        //     // implement dialog here
        //   }
        // }
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

  clearIverlayVisability() {
    emit(0);
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
                if (fastMove.text.isNotEmpty) {
                  int pageIndex = 604 - int.parse(pageNum.text.toEnglish);
                  pageIndex = pageIndex > 604 ? 604 : pageIndex;

                  Navigator.of(context).pop();
                  AudioControlCubit.get(context)
                      .updatePage(int.parse(pageNum.text.toEnglish));
                  log(int.parse(pageNum.text.toEnglish).toString());

                  fastMove.text = "";
                  surahName.text = "";
                  pageNum.text = "";
                  emit(0);
                  QuranCubit.get(context).pageController.jumpToPage(pageIndex);
                } else {
                  showToast("يجب ادخال رقم الصفحة او اسم السورة",
                      AppColor.blueColor.withOpacity(.95));
                }

                //  log("int.parse(pageNum.text.toEnglish) ${int.parse(pageNum.text.toEnglish)} ");
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

  showMoshafIndex(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration:
              BoxDecoration(color: AppColor.blueColor.withOpacity(0.85)),
          height: Get.height / 7 * 6,
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(
                  height: 21.h,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    IconButton(onPressed:() {
                      Get.back();
                    } , icon: const Icon(Icons.close,size: 30,color: Colors.white,)),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.only(left: 36.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                IndexCubit.moshafIndexTypes.length,
                                (index) => GestureDetector(onTap: () {
                                  int toggle=index==0?0:1;
                                  IndexCubit.get(context).toggleIndex(toggle);
                                },
                                  child: BlocBuilder<IndexCubit, int>(
                                        builder: (context, indexState) {
                                          return Container(
                                            alignment: Alignment.center,
                                            width: 88.w,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              color: indexState==index?Colors.white:null,
                                                border: Border.all(
                                                    width: 1, color: Colors.white),
                                                borderRadius: index == 0
                                                    ? const BorderRadius.only(
                                                        topRight: Radius.circular(25),
                                                        bottomRight: Radius.circular(25))
                                                    : const BorderRadius.only(
                                                        bottomLeft: Radius.circular(25),
                                                        topLeft: Radius.circular(25))),
                                            child: Text(
                                              IndexCubit.moshafIndexTypes[index],
                                              style:  TextStyle(fontWeight: FontWeight.w500,
                                                  color:indexState==index?AppColor.blueColor:Colors.white, fontSize: 20.r),
                                            ),
                                          );
                                        },
                                      ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: BlocBuilder<IndexCubit, int>(
                      builder: (context, state) {
                           
                        return ListView.builder(

                          itemCount:state==0? IndexCubit.getQuranSurah().length:IndexCubit.getQuranJuz().length,
                          itemBuilder: (context, parentIndex) =>
                              Visibility(visible: state==0,
                                replacement:  JuzComponent(parentIndex: parentIndex,),
                                child: QuranSoraComponent(
                                
                                indexEntity: IndexCubit.getQuranSurah()[parentIndex],),
                              ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



//  static showMoshafNotes(BuildContext context) {
//     showBottomSheet(
//       context: context,
//       builder: (context) {
//         return 
//         Container(
//           decoration:
//               BoxDecoration(color: AppColor.blueColor.withOpacity(0.85)),
//           height: Get.height / 7 * 6,
//           width: Get.width,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15.w),
//             child: Column(
//               children: [
//                   const SizedBox(height: 15,),
//                  Row(mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
                  

//                     IconButton(onPressed:() {
//                       Get.back();
//                     } , icon: const Icon(Icons.close,size: 30,color: Colors.white,)),
//                     Expanded(
//                       child: Center(
//                         child: Padding(
//                           padding:  EdgeInsets.only(left: 36.w),
//                           child: const Text("الملاحظات",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500),)   ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20,),

//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 20.h),
//                     child: 
//                     // implement slide to action here
                    
//                     const NoteAyahListView()
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }






  void onChangedDebounced(String value, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      performHeavyComputation(value, context);
    });
  }

  Future<void> performHeavyComputation(
      String value, BuildContext context) async {
    bool isPage = isNumeric(value);
    fastMove.text =
        value.toArabic; // Assuming toArabic() is an extension method
    if (isPage) {
      pageNum.text =
          value.toArabic; // Assuming toArabic() is an extension method
      final result = await compute(_heavyComputationForPage,
          {"page": int.parse(value) - 1, "context": context});
      surahName.text =
          "${result!['surahNumberText']}.${result['surahNameText']}";
    } else {
      final result = await compute(
          _heavyComputationForSurah, {"surah": value, "context": context});
      if (result != null) {
        pageNum.text = result['pageNumberText']
            .toString()
            .toArabic; // Assuming toArabic() is an extension method
        surahName.text =
            "${result['surahNumberText'].toString().toArabic}.$value"; // Assuming toArabic() is an extension method
      }
    }
  }

  static Map<String, dynamic>? _heavyComputationForPage(
      Map<String, dynamic> args) {
    // Perform your heavy computation here
    // For example, fetching Surah name and number from a page number
    int page = args['page'];
    BuildContext context = args['context'];
    final surahNameText = QuranCubit.get(context).getSurahNameFromPage(page);
    final surahNumberText =
        QuranCubit.get(context).getSurahNumberFromPage(page);
    return {'surahNameText': surahNameText, 'surahNumberText': surahNumberText};
  }

  static Map<String, dynamic>? _heavyComputationForSurah(
      Map<String, dynamic> args) {
    // Perform your heavy computation here
    // For example, fetching Surah number and start page from Surah name
    String surah = args['surah'];
    BuildContext context = args['context'];
    final surahNumberText = QuranCubit.get(context).getSurahNumber(surah);
    final pageNumberText = QuranCubit.get(context).getSurahStartPage(surah);
    if (surahNumberText != null && pageNumberText != null) {
      return {
        'surahNumberText': surahNumberText,
        'pageNumberText': pageNumberText
      };
    }
    return null;
  }
}
