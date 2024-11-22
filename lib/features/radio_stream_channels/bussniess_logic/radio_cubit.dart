import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/models/radio_model.dart';
import '../data/repositories/radio_repository.dart';
import 'radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<List<Channel>?>categories = RadioRepository.fetchRadioChannels();

  RadioCubit() : super(const RadioState());

  // تشغيل أو إيقاف القناة الحالية
  void playOrPause({Channel? selectesChannel,int?  currentIndex}) async {
    final channel =selectesChannel?? currentChannel;
    if (channel == null) return;

    if (state.isPlaying && state.playingUrl == channel.url) {
      await _audioPlayer.stop();
      emit(state.copyWith(isPlaying: false, playingUrl: null));
    } else {
      emit(state.copyWith(isLoading: true));
      await _audioPlayer.play(UrlSource(channel.url!));
      emit(state.copyWith(
        isLoading: false,
        isPlaying: true,
        currentIndex: currentIndex,
        playingUrl: channel.url,
      ));
    }
  }

  // الحصول على القناة الحالية
  Channel? get currentChannel {
    if (state.radioCatIndex < categories.length &&
        state.currentIndex < categories[state.radioCatIndex]!.length) {
      return categories[state.radioCatIndex]![state.currentIndex];
    }
    return null;
  }

  // تغيير التصنيف
  void changeRadioCat(int index) {
    emit(state.copyWith(
      radioCatIndex: index,
      currentIndex: 0,
      playingUrl: null,
      isPlaying: false,
    ));
    _audioPlayer.stop();
  }

  // الانتقال إلى القناة التالية
  void next() {
    if (state.currentIndex < categories[state.radioCatIndex]!.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
      playOrPause();
    }
  }

  // الانتقال إلى القناة السابقة
  void previous() {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
      playOrPause();
    }
  }
}