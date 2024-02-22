import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../data/models/quran_model.dart';
import '../../data/repository/quran_repository.dart';

class QuranSowarCubit extends Cubit<List<SoraModel>> {
  QuranSowarCubit() : super(QuranRepository.getAllQuranSowar());

   getAllQuranSowar() => emit(state );



   goToSoraDetailsEsvent(SoraModel soraModel){

    Get.toNamed(AppRouteName.soraDetails,arguments: soraModel);
   }
  //  searchOnSora() => emit(state);
}