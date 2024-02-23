import 'package:lnastaqim/features/radio_stream_channels/data/data_sources/local_data_sources/radio_json.dart';
import 'package:lnastaqim/features/radio_stream_channels/data/models/radioModel.dart';
import 'package:radio_player/radio_player.dart';

class RadioRepository {
  static RadioModel fetchRadioChannels() =>
      RadioModel.fromJson(Radio.radioJsonData);

  static Future<void> setChannel(RadioPlayer radioPlayer,
          {required String title, required String url, String? img}) =>
      radioPlayer.setChannel(title: title, url: url, imagePath: img);

  static Future<void> play(RadioPlayer radioPlayer) => radioPlayer.play();

  static Future<void> stop(RadioPlayer radioPlayer) => radioPlayer.stop();

  static Future<void> pause(RadioPlayer radioPlayer) => radioPlayer.pause();
}
