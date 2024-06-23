import 'package:flutter_bloc/flutter_bloc.dart';
class QuranSowarVersusCubit extends Cubit<int> {
  QuranSowarVersusCubit() : super(-1);

   selectedVerse(int selectedVurse) => emit(selectedVurse);
   
}