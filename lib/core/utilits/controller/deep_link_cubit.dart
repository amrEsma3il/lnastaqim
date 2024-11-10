
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeepLinkCubit extends Cubit<Uri?> {
  // Event Channel creation
  static const EventChannel streaam = EventChannel('qr.lnastaqim/events');

  // Method channel creation
  static const MethodChannel platform = MethodChannel('qr.lnastaqim/channel');

  DeepLinkCubit() : super(null) {
    // Checking application start by deep link
    startUri().then((initialUri) {
      if (initialUri != null) {
        _onRedirected(initialUri);
      }
    });

    // Checking broadcast stream, if deep link was clicked in opened application
    streaam.receiveBroadcastStream().listen((dynamic url) => _onRedirected(url));

    // Listening for screen navigation from native side via MethodChannel
    platform.setMethodCallHandler((call) async {
      if (call.method == "navigateTo") {
        // Handle navigation based on the URL passed from Kotlin
        String? url = call.arguments;
        _onRedirected(url);
      }
    });
  }

  // Handle the redirection and update the Cubit state
  void _onRedirected(String? urlString) {
    if (urlString != null) {
      Uri uri = Uri.parse(urlString);
      emit(uri); // Updating the Cubit state with the parsed URI
    }
  }

  // Retrieve the initial deep link if the app was launched via deep link
  Future<String?> startUri() async {
    try {
      return platform.invokeMethod<String>('initialLink');
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
      return null;
    }
  }
}
