import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/radio_stream_channels/data/models/radioModel.dart';
import 'package:lnastaqim/features/radio_stream_channels/data/repositories/radio_repository.dart';
import 'package:meta/meta.dart';
import 'package:radio_player/radio_player.dart';


part 'radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit() : super(RadioInitial());
  static RadioCubit get(context) => BlocProvider.of(context);

  RadioModel radioChannels = RadioRepository.fetchRadioChannels();

  RadioPlayer radioPlayer = RadioPlayer();

}
