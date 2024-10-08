import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<void> downloadHadithFiles(String url, String fileName) async {
  Dio dio = Dio();

  // Get the directory to store the files
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String filePath = "${appDocDir.path}/$fileName";

  try {
    await dio.download(url, filePath);
    print("File downloaded to $filePath");
  } catch (e) {
    print("Download failed: $e");
  }
}
