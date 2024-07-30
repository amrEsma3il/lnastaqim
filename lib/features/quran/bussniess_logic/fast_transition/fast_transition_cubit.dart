import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../../../core/utilits/functions/check.dart';
import '../quran/quran_cubit.dart';
class FastTransitionCubit extends Cubit<Map<String,dynamic>> {
  FastTransitionCubit() : super({"fastMove":"١","pageNumber":"١","surahName":"١.الفاتحة"});

  static FastTransitionCubit get(BuildContext context) =>
      BlocProvider.of<FastTransitionCubit>(context);



clearEvent(){
  emit({"fastMove":"١","pageNumber":"١","surahName":"١.الفاتحة"});
}
  onChangedEvent(String input,BuildContext context) {
    bool isPage = isNumeric(input);
                  String fastMove=input.toArabic  ;
                  String pageNumber=""  ;
                  String surahName=""  ;

                    if (isPage) {
                    
                      pageNumber= fastMove;
                      String surahNameText = QuranCubit.get(context)
                          .getSurahNameFromPage(int.parse(input) - 1);
                      int surahNumberText = QuranCubit.get(context)
                          .getSurahNumberFromPage(int.parse(input) - 1);
                     surahName =
                          "${surahNumberText.toString().toArabic}.$surahNameText";
                    } else {
                      int? surahNumberText =
                          QuranCubit.get(context).getSurahNumber(input);
                      int? pageNumberText =
                          QuranCubit.get(context).getSurahStartPage(input);
                      if (surahNumberText != null && pageNumberText != null) {
                        pageNumber = pageNumberText.toString().toArabic;
                        surahName =
                            "${surahNumberText.toString().toArabic}.${input.toString()}";
                      }
                    }


                    emit({"fastMove":fastMove,"pageNumber":pageNumber,"surahName":surahName});
  }
  //  searchOnSora() => emit(state);
}
