import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeTafseerCubit extends Cubit<int> {
  ChangeTafseerCubit() : super(0);
  static ChangeTafseerCubit get(context) => BlocProvider.of(context);

  void changeColor(int index) {
    if (state != index) {
      emit(index);
    }
  }
}
