import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/local_database/quran/quran_v2.dart';

import '../../data/models/select_aya_model.dart';
import '../../data/models/surahs_model.dart';


class QuranCubit extends Cubit<SelectAyaModel> {
  QuranCubit() : super(SelectAyaModel(ayaNumber: -1,offset: Offset(0,0)));
  static QuranCubit get(context) => BlocProvider.of(context);

  List<Surah> surahs = [];
  List<List<Ayah>> pages = [];
  List<Ayah> allAyahs = [];
  List<int> downThePageIndex = [
    75,
    206,
    330,
    340,
    348,
    365,
    375,
    413,
    416,
    434,
    444,
    451,
    497,
    505,
    524,
    547,
    554,
    556,
    583
  ];
  List<int> topOfThePageIndex = [
    76,
    207,
    331,
    341,
    349,
    366,
    376,
    414,
    417,
    435,
    445,
    452,
    498,
    506,
    525,
    548,
    554,
    555,
    557,
    583,
    584
  ];
  int selectedAyahNo=-1;

onMoshafPageChangedEvent(){

  emit(SelectAyaModel(ayaNumber: -1,offset: Offset(0,0)));
}


   toggleAyahSelection({required SelectAyaModel selectAya}) {
    if(
    selectAya.ayaNumber==state.ayaNumber

    ){
      emit(SelectAyaModel(ayaNumber: -1,offset: Offset(0,0)));

    }else{
      emit(selectAya);

    }

  }


   // toggleAyahSelection({required int ayaNumber}) {
   //  if (state.contains(ayaNumber)) {
   //    state.remove(ayaNumber);
   //    emit(state);
   //  } else {
   //    state.clear();
   //    state.add(ayaNumber);
   //    emit(state);
   //
   //  }

  // }

  Future<void> loadQuran() async {
    surahs = quranSurahs.map((s) => Surah.fromJson(s)).toList();
    for (final surah in surahs) {
      allAyahs.addAll(surah.ayahs);
    }
    List.generate(604, (pageIndex) {
      pages.add(allAyahs.where((ayah) => ayah.page == pageIndex + 1).toList());
    });
  }

  List<List<Ayah>> getCurrentPageAyahsSeparatedForBasmalah(int pageIndex) =>
      pages[pageIndex]
          .splitBetween((f, s) => f.ayahNumber > s.ayahNumber)
          .toList();

  int getSurahNumberFromPage(int pageNumber) => surahs
      .firstWhere(
          (s) => s.ayahs.contains(getCurrentPageAyahs(pageNumber).first))
      .surahNumber;

  List<Ayah> getCurrentPageAyahs(int pageIndex) => pages[pageIndex];

   Ayah getPageInfo(int page) => allAyahs.firstWhere((a) => a.page == page + 1);

  int getSurahNumberByAyah(Ayah ayah) =>
      surahs.firstWhere((s) => s.ayahs.contains(ayah)).surahNumber;


  String getSurahNameFromPage(int pageNumber) {
    try {
      return surahs
          .firstWhere(
              (s) => s.ayahs.contains(getCurrentPageAyahs(pageNumber).first))
          .arabicName;
    } catch (e) {
      return "Surah not found";
    }
  }
}
