import 'dart:developer';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/local_database/quran/quran_v2.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../../../core/local_database/quran/quran_local_database.dart';
import '../../../../core/local_database/quran/quran_transition_json.dart';
import '../../../../core/utilits/functions/search_string_pattern/boyer_moore_algo.dart'
    as boyer_more;
import '../../data/models/search_ayah_entity.dart';
import '../../data/models/select_aya_model.dart';
import '../../data/models/surahs_model.dart';
import '../screen_tap_Visibility/screen_tap_visability.dart';
// import '../../../../core/utilits/functions/search_string_pattern/kmp_algo.dart' as kmp;

class QuranCubit extends Cubit<SelectAyaModel> {
  QuranCubit() : super(SelectAyaModel(ayaNumber: -1, offset: const Offset(0, 0)));
  static QuranCubit get(context) => BlocProvider.of(context);
  final ScreenOverlayCubit screenOverlayCubit=ScreenOverlayCubit();
  final LayerLink layerLink = LayerLink();
 PageController pageController = PageController(
    
    );
  // TextEditingController searchController = TextEditingController();
  TextEditingController juzHizbSurahNoController = TextEditingController();
  List<Surah> surahs = [];
  List<List<Ayah>> pages = [];
  List<Ayah> allAyahs = [];
  Map<int, int> pageToHizbQuarterMap = {};
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
  //search vars
  //search type: normal , authmanic.
  String searchType = 'normal';
  // quran whole -> 1  juz -> 2   hizb -> 3  surah -> 4 .
  int searchWhere = 1;
  bool isSearch = false;
  int juzOrHizbOrSurahNo = 0;

  int selectedAyahNo = -1;
  // static List<Map<String,dynamic>> menuItems=QuranRepository.menuItems;

  clearMenuOverlayEvent() {
    emit(SelectAyaModel(ayaNumber: -1, offset: const Offset(0, 0)));
      //TODO:implement aya select visible overlay correct
    //  screenOverlayCubit.stream.listen((visibileState) {
      // React to changes in FirstCubit's state
  

//   if (visibileState==0||visibileState==1) {
//     screenOverlayCubit.keepOverlayState(visibileState);
// }

    // });
    
  }

  toggleAyahSelection({required SelectAyaModel selectAya}) {
    if (selectAya.ayaNumber == state.ayaNumber) {
      emit(SelectAyaModel(ayaNumber: -1, offset: const Offset(0, 0)));
    } else {
      emit(selectAya);
    }
  }


  searchAya(int ayaNumber) {
 
      emit(SelectAyaModel(ayaNumber:ayaNumber , offset: const Offset(0, 0)));
    
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


int getPageNumber(int ayanumber) {
  int pageNum=1;
  for (var surah in quranSurahs) {
    for (var ayah in surah['ayahs']) {
      if (ayah['number'] == ayanumber) {
        pageNum= ayah['page'];
        log(pageNum.toString());
      }
    }
  }
  return pageNum;
}


 String? getSurahNameFromPage2(int page){

List<Map<String, dynamic>> quranSowar=QuranTransition.quranSowar;
for (int i = 0; i < quranSowar.length; i++) {

  if (page>=quranSowar[i]["start_page"] && page <= quranSowar[i]["end_page"] ) {
    return quranSowar[i]["name"];
  }

}
  return null;
  }




   int? getSurahNumberFromPage2(int page){

List<Map<String, dynamic>> quranSowar=QuranTransition.quranSowar;
for (int i = 0; i < quranSowar.length; i++) {

  if (page>=quranSowar[i]["start_page"] && page <= quranSowar[i]["end_page"] ) {
    return quranSowar[i]["id"];
  }

}
  return null;
  }
  
  int getSurahNumberByName(String surahName) {
    try {
      return surahs
          .firstWhere((surah) => surah.arabicName == surahName)
          .surahNumber;
    } catch (e) {
      return -1;
    }
  }

  List<Ayah> getCurrentPageAyahs(int pageIndex) => pages[pageIndex];

  Ayah getPageInfo(int page) => allAyahs.firstWhere((a) => a.page == page + 1);

  int getSurahNumberByAyah(Ayah ayah) =>
      surahs.firstWhere((s) => s.ayahs.contains(ayah)).surahNumber;



  String getSurahNameFromAyah(Ayah ayah) {
    try {
      return surahs.firstWhere((s) => s.ayahs.contains(ayah)).arabicName;
    } catch (e) {
      return "Surah not found";
    }
  }

  //surah functions
  int? getSurahStartPage(String surahName) {
  for (var surah in QuranDataBase.quranJsonData) {
    if (surah['name'] == surahName) {
      return surah['startPage'];
    }
  }
  // Return null if the Surah name is not found
  return null;
}

  int?  getSurahNumber(String surahName) {
  for (var surah in QuranDataBase.quranJsonData) {
    if (surah['name'] == surahName) {
      return surah['id'];
    }
  }
  // Return null if the Surah name is not found
  return null;
}

  Ayah getSelectedAyah(int pageNumber, int ayahNumber) {
    List<Ayah> pageAyahs = getCurrentPageAyahs(pageNumber);
    Ayah selectedAyah =
        pageAyahs.firstWhere((ayah) => ayah.ayahNumber == ayahNumber);
    return selectedAyah;
  }

  String getHizbQuarterDisplayByPage(int pageNumber) {
    final List<Ayah> currentPageAyahs =
        allAyahs.where((ayah) => ayah.page == pageNumber).toList();
    if (currentPageAyahs.isEmpty) return "";

    // Find the highest Hizb quarter on the current page
    int? currentMaxHizbQuarter =
        currentPageAyahs.map((ayah) => ayah.hizbQuarter).reduce(math.max);

    // Store/update the highest Hizb quarter for this page
    pageToHizbQuarterMap[pageNumber] = currentMaxHizbQuarter;

    // For displaying the Hizb quarter, check if this is a new Hizb quarter different from the previous page's Hizb quarter
    // For the first page, there is no "previous page" to compare, so display its Hizb quarter
    if (pageNumber == 1 ||
        pageToHizbQuarterMap[pageNumber - 1] != currentMaxHizbQuarter) {
      int hizbNumber = ((currentMaxHizbQuarter - 1) ~/ 4) + 1;
      int quarterPosition = (currentMaxHizbQuarter - 1) % 4;

      switch (quarterPosition) {
        case 0:
          return ", الحزب ${'$hizbNumber'.toArabic}";
        case 1:
          return ", ١/٤ الحزب ${'$hizbNumber'.toArabic}";
        case 2:
          return ", ١/٢ الحزب ${'$hizbNumber'.toArabic}";
        case 3:
          return ", ٣/٤ الحزب ${'$hizbNumber'.toArabic}";
        default:
          return "";
      }
    }

    // If the page's Hizb quarter is the same as the previous page, do not display it again
    return "";
  }

  bool getSajdaInfoForPage(List<Ayah> pageAyahs) {
    for (var ayah in pageAyahs) {
      if (ayah.sajda != false && ayah.sajda is Map) {
        var sajdaDetails = ayah.sajda;
        if (sajdaDetails['recommended'] == true ||
            sajdaDetails['obligatory'] == true) {
          return true;
        }
      }
    }
    // No sajda found on this page
    return false;
  }

  // search logic
  List<Ayah> getJuzByNo(int juzNo) =>
      allAyahs.where((aya) => aya.juz == juzNo).toList();
  List<Ayah> getHizbByNo(int hizbNo) =>
      allAyahs.where((aya) => aya.hizbQuarter == hizbNo).toList();
  List<Ayah> getSurahByNo(String surahName) =>
      surahs.firstWhere((surah) => surah.arabicName == surahName).ayahs;

  List<SearchAyahEntity> searchInMoshaf(
      {String? type = 'normal',
      int? searchWhere = 1,
      String? surahName,
      int? noOfjuzOrHizbOrSurah,
      required String searchText}) {
    List<SearchAyahEntity> ayatOfSearch = [];

    List<Ayah> filterdAyat = searchWhere == 1
        ? allAyahs
        : (searchWhere == 2
            ? getJuzByNo(noOfjuzOrHizbOrSurah!)
            : (searchWhere == 3
                ? getHizbByNo(noOfjuzOrHizbOrSurah!)
                : getSurahByNo(surahName!)));
    for (int i = 0; i <= filterdAyat.length - 1; i++) {
      List<int> matchesPositions = boyer_more.searchPattern(
          type == 'normal' ? filterdAyat[i].ayaTextEmlaey : filterdAyat[i].text,
          searchText);
      if (matchesPositions.isNotEmpty) {
        ayatOfSearch.add(SearchAyahEntity(
            aya: filterdAyat[i], startPosition: matchesPositions[0]));
      }
    }

    return ayatOfSearch;
  }


  clearScreen(BuildContext context){
    clearMenuOverlayEvent();
    ScreenOverlayCubit.get(context).clearIverlayVisability();
  }
}
