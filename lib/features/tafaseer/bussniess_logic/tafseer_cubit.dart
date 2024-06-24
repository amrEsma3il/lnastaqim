import 'package:flutter_bloc/flutter_bloc.dart';

class TafseerCubit extends Cubit<String> {
  TafseerCubit() : super('');

  static TafseerCubit get(context) => BlocProvider.of(context);

  int? ayanumber;

  bool tafsir = false;

  void getayanumber(ayanum) {
    ayanumber = ayanum;
  }

  getAyaTafasser(int ayaNum, List<Map<String, dynamic>> listOfTafasser) {
    String text = listOfTafasser
        .firstWhere((aya) => aya['index'] == ayaNum)['text']
        .toString();
    emit(text);
    return text;
  }
}
