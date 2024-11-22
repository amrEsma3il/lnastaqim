import 'package:lnastaqim/features/radio_stream_channels/data/data_sources/local_data_sources/radio_json.dart';

import '../models/radio_model.dart';


class RadioRepository {
  static List<List<Channel>?> fetchRadioChannels()
{   RadioModel data=   RadioModel.fromJson(Radio.radioJsonData);

return [data.quran,data.reciters,data.other];

}


}