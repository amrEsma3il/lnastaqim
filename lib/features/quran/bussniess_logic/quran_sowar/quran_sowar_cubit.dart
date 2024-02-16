import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/quran_model.dart';
import '../../data/repository/quran_repository.dart';

class QuranSowarCubit extends Cubit<List<QuranModel>> {
  QuranSowarCubit() : super(QuranRepository.getAllQuranSowar());

   getAllQuranSowar() => emit(state );
  //  searchOnSora() => emit(state);
}