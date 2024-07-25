import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
Future<String> getImageFilePath(String asset) async {
  final byteData = await rootBundle.load(asset);
  final file = File('${(await getTemporaryDirectory()).path}/${asset.split('/').last}');
  await file.writeAsBytes(byteData.buffer.asUint8List());
  return file.path;
}