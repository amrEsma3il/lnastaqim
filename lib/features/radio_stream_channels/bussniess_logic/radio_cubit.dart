// import 'package:flutter/services.dart';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utilits/functions/toast_message.dart';
import '../../../core/utilits/services/audio_service/audio_players.dart';
import '../../../core/utilits/services/audio_service/players_key.dart';
import '../../../core/utilits/services/audio_service/playback_coordinator.dart';
import '../../../core/utilits/services/local_notification_service.dart';
import '../data/models/radio_model.dart';
import '../data/repositories/radio_repository.dart';
import 'radio_state.dart';
import 'dart:developer' as dev;

class RadioCubit extends Cubit<RadioState> {
  final AudioPlayer audioPlayer = AudioPlayers().getPlayer(
    NotificationKeys.radio,
  );
  ReceivePort? receivePort;

  final List<List<Channel>?> categories = RadioRepository.fetchRadioChannels();

  RadioCubit() : super(RadioState.init()) {
    initListeners();

    registerPort();
  }

  initListeners() {
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        // LocalNotificationService.showMediaNotification(
        //       groupKey: "radio",

        //   isPlaying: true,
        //   id: 31,
        //   keyFeature: NotificationKeys.radio,

        //   title: currentChannel!.title??"قناة الرحمة");
        emit(this.state.copyWith(isPlaying: true));
      } else {
        //   LocalNotificationService.showMediaNotification(
        //         groupKey: "radio",

        // isPlaying: false,
        // id: 31,
        // keyFeature: NotificationKeys.radio,

        // title: currentChannel!.title??"قناة الرحمة");
        emit(this.state.copyWith(isPlaying: false, playingUrl: null));
      }
    });
  }

  Future<void> registerPort() async {
    receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(
      receivePort!.sendPort,
      NotificationKeys.radio,
    );

    receivePort!.listen((message) async {
      dev.log('Received message from : $message');
      await _handleNotificationAction(message);
    });
  }

  Future<void> _handleNotificationAction(String action) async {
    switch (action) {
      case 'play':
        await playOrPause();
        break;
      case 'pause':
        await playOrPause();
        break;
      case 'stop':
        await stop();
        break;

      case 'previous':
        await previous();

        break;

      case 'next':
        await next();

        break;
    }
  }

  // تشغيل أو إيقاف القناة الحالية
  Future<void> playOrPause({
    Channel? selectesChannel,
    int? currentIndex,
  }) async {
    final channel = selectesChannel ?? currentChannel;
    if (channel == null) return;

    if (state.isPlaying && state.playingUrl == channel.url) {
      await stop();
      await LocalNotificationService.instance.showMediaNotification(
        groupKey: "radio",

        isPlaying: false,
        id: 31,
        keyFeature: NotificationKeys.radio,

        title: channel.title ?? "قناة الرحمة",
      );
    } else {
      emit(
        state.copyWith(
          audioState: AudioFetchLoading(),
          currentIndex: currentIndex,
        ),
      );
      try {
        await PlaybackCoordinator.instance.activate(NotificationKeys.radio);

        await LocalNotificationService.instance.showMediaNotification(
          groupKey: "radio",
          isPlaying: true,
          id: 31,
          keyFeature: NotificationKeys.radio,

          title: channel.title ?? "قناة الرحمة",
        );
        await audioPlayer.play(UrlSource(channel.url!));
        emit(
          state.copyWith(
            audioState: AudioFetchSuccess(),
            isPlaying: true,

            playingUrl: channel.url,
          ),
        );
      } catch (e) {
        // dev.log(e.message??"");
        //       dev.log(e.details.toString());
        //             dev.log(e.stacktrace??"");
        //                   dev.log(e.code);

        dev.log(e.toString());
        await stop();
        showToast("توجد مشكلة اثناء تشغيل الراديو", AppColor.blueTint2);
      }
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
  Future<void> changeRadioCat(int index) async {
    if (index != state.radioCatIndex) {
      await stop();
      emit(state.copyWith(radioCatIndex: index, currentIndex: 0));
      // await  playOrPause(selectesChannel: currentChannel);
    }
  }

  changeChannel({
    required Channel selectesChannel,
    required int currentIndex,
  }) async {
    dev.log("change channel current: $currentChannel");
    dev.log("change channel selectes: $selectesChannel");
    if (selectesChannel != currentChannel) {
      await stop();
      emit(state.copyWith(currentIndex: currentIndex));
      // await playOrPause(selectesChannel: selectesChannel,currentIndex: currentIndex);
    }
  }

  // الانتقال إلى القناة التالية
  Future<void> next() async {
    if (state.currentIndex < categories[state.radioCatIndex]!.length - 1) {
      await stop();
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
      //  await playOrPause();
    }
  }

  // الانتقال إلى القناة السابقة
  Future<void> previous() async {
    if (state.currentIndex > 0) {
      await stop();
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
      // await  playOrPause();
    }
  }

  // توقف الاغاني
  Future<void> stop() async {
    await audioPlayer.stop();
    emit(
      state.copyWith(
        isPlaying: false,
        audioState: AudioFetchInit(),
        playingUrl: null,
      ),
    );
  }

  @override
  Future<void> close() async {
    IsolateNameServer.removePortNameMapping(NotificationKeys.radio);
    receivePort?.close();
    await AudioPlayers().disposePlayer(NotificationKeys.radio);
    return super.close();
  }
}
