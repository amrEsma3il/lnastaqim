import 'package:flutter_bloc/flutter_bloc.dart';

class SharedAzkarCubit extends Cubit<Map<String, bool>> {
  SharedAzkarCubit()
      : super({
          'azkar': false,
          'adi3a': false,
          'other': false,
          'sibha': false,
        });

  void toggleVisibility(String category) {
    if (state.containsKey(category)) {
      emit({...state, category: !state[category]!});
    }
  }
}
