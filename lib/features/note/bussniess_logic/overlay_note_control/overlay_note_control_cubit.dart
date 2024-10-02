import 'package:flutter_bloc/flutter_bloc.dart';

class OverlayNoteControlCubit extends Cubit<bool> {
  OverlayNoteControlCubit() : super(false);

  void toggle() => emit(!state); 
}
