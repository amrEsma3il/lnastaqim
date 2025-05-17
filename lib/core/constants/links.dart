import 'dart:io';

import 'package:lnastaqim/core/constants/keys.dart';

class AppLinks {
  static String get storeUrl {
    if (Platform.isAndroid) {
      return 'https://play.google.com/store/apps/details?id=${AppKeys.packageName}';
    } else {
      return 'https://apps.apple.com/app/${AppKeys.packageName}';
    }
  }

  static const String appLinks = "https://alquran.cloud";
  static const String deepLinks = "qr://muslim.lnastaqim";
}
