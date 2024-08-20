import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../quran_cubit.dart';
import 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(SurahIndexState());

  static IndexCubit get(BuildContext context) =>
      BlocProvider.of<IndexCubit>(context);

  goToSoraDetailsEsvent(BuildContext context, int page) {
    QuranCubit.get(context).pageController.jumpToPage(604 - page);
  }

  static const List<String> moshafIndexTypes = [  "السور","الاجزاء","الاحزاب"

  ];

  changeSelector(int index) {
    switch (index) {
      case 0:
        emit(SurahIndexState());
        break;
      case 1:
        emit(ChapterIndexState());
        break;

      case 2:
        emit(HizbIndexState());
        break;
    }
  }
}
