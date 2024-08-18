import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/quran_model.dart';
import '../../data/repository/quran_repository.dart';
import '../quran/quran_cubit.dart';

class QuranSowarCubit extends Cubit<List<MoshafSurahIndexModel>> {
  QuranSowarCubit() : super(QuranRepository.getAllQuranSowar());

  // getAllQuranSowar() => emit(state);

  goToSoraDetailsEsvent(BuildContext context, MoshafSurahIndexModel soraModel) {
    QuranCubit.get(context).pageController.jumpToPage(604-soraModel.startPage);
    // Get.offNamed(AppRouteName.moshaf);
  }
  //  searchOnSora() => emit(state);
}
