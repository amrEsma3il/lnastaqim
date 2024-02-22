import 'package:flutter_bloc/flutter_bloc.dart';
class QuranSowarVersusCubit extends Cubit<int> {
  QuranSowarVersusCubit() : super(0);

   selectedVerse(int selectedVurse) => emit(selectedVurse);
}