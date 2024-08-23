import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/quran_model.dart';
import '../../../data/repository/quran_repository.dart';
import '../quran_cubit.dart';

class IndexCubit extends Cubit<int> {
  IndexCubit() : super(0);

  static IndexCubit get(BuildContext context) =>
      BlocProvider.of<IndexCubit>(context);

  moveToPageEvent(BuildContext context, int page) {
    QuranCubit.get(context).pageController.jumpToPage(604 - page);
  }

  static const List<String> moshafIndexTypes = [  "السور","الاجزاء"

  ];

  toggleIndex(int type){
emit(type);

  }

    static List<SurahModel> getQuranSurah() =>
    QuranRepository.getQuranSurah();


        static List<JuzModel> getQuranJuz() =>
     QuranRepository.getQuranJuz();

}
