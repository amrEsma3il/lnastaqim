import 'package:flutter_bloc/flutter_bloc.dart';


class SearchOrNot extends Cubit<bool> {
  SearchOrNot() : super(false);

   swithSearchStatus() => emit(!state );

}