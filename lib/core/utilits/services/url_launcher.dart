import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> launchToUrl(String url,{bool isExternal = false,
  }) async {
    
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url),
        mode:isExternal? LaunchMode.externalApplication:LaunchMode.platformDefault);
  } else {
      throw 'Could not launch $url';
    }
  }

}