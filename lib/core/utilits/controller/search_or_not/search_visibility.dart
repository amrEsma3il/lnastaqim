import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchVisabilityCubit extends Cubit<bool> {
  SearchVisabilityCubit() : super(false);
 static SearchVisabilityCubit get(BuildContext context) =>
      BlocProvider.of<SearchVisabilityCubit>(context);

  searchVisability() => emit(!state);
}
