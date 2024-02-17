import 'package:flutter_bloc/flutter_bloc.dart';


class SoraSelected extends Cubit<int> {
  SoraSelected() : super(0);

   selectSora(int ayaNymber) => emit(ayaNymber );
  //  searchOnSora() => emit(state);
}