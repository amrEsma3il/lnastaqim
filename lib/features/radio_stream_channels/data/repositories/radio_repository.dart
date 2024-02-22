import 'package:lnastaqim/features/radio_stream_channels/data/data_sources/local_data_sources/radioJson.dart';
import 'package:lnastaqim/features/radio_stream_channels/data/models/radioModel.dart';

class RadioRepository {
  static RadioModel fetchRadioChannels() =>
      RadioModel.fromJson(Radio.radioJsonData.first);
}
