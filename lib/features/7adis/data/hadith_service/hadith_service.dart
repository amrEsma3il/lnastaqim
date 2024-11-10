import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/a7adith_model.dart';

Future<bool> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  return status.isGranted;
}

Future<void> downloadHadithFiles(String url, String fileName,
    {Function(double)? onProgress}) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$fileName';

  var dio = Dio();

  // Listening to download progress
  await dio.download(url, filePath, onReceiveProgress: (received, total) {
    if (total != -1) {
      final progress = received / total;
      if (onProgress != null) {
        onProgress(progress); // Call the callback with progress
      }
    }
  });
}

Future<A7adithModel?> getBukhariHadiths() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/bukhari.json');

    if (await file.exists()) {
      String fileContent = await file.readAsString();

      print("File content: $fileContent");

      Map<String, dynamic> jsonData = json.decode(fileContent);

      A7adithModel hadiths = A7adithModel.fromJson(jsonData);
      return hadiths;
    } else {
      print("File does not exist");
      return null;
    }
  } catch (e) {
    print("Error reading or parsing the file: $e");
    return null;
  }
}

Future<A7adithModel?> getMuslimHadiths() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/muslim.json');

    if (await file.exists()) {
      String fileContent = await file.readAsString();

      print("File content: $fileContent");

      Map<String, dynamic> jsonData = json.decode(fileContent);

      A7adithModel hadiths = A7adithModel.fromJson(jsonData);
      return hadiths;
    } else {
      print("File does not exist");
      return null;
    }
  } catch (e) {
    print("Error reading or parsing the file: $e");
    return null;
  }
}

Future<A7adithModel?> getAbuDawudHadiths() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/abudawud.json');

    if (await file.exists()) {
      String fileContent = await file.readAsString();

      print("File content: $fileContent");

      Map<String, dynamic> jsonData = json.decode(fileContent);

      A7adithModel hadiths = A7adithModel.fromJson(jsonData);
      return hadiths;
    } else {
      print("File does not exist");
      return null;
    }
  } catch (e) {
    print("Error reading or parsing the file: $e");
    return null;
  }
}

Future<A7adithModel?> getTirmidhiHadiths() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/tirmidhi.json');

    if (await file.exists()) {
      String fileContent = await file.readAsString();

      print("File content: $fileContent");

      Map<String, dynamic> jsonData = json.decode(fileContent);

      A7adithModel hadiths = A7adithModel.fromJson(jsonData);
      return hadiths;
    } else {
      print("File does not exist");
      return null;
    }
  } catch (e) {
    print("Error reading or parsing the file: $e");
    return null;
  }
}

Future<A7adithModel?> getNasaiHadiths() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/nasai.json');

    if (await file.exists()) {
      String fileContent = await file.readAsString();

      print("File content: $fileContent");

      Map<String, dynamic> jsonData = json.decode(fileContent);

      A7adithModel hadiths = A7adithModel.fromJson(jsonData);
      return hadiths;
    } else {
      print("File does not exist");
      return null;
    }
  } catch (e) {
    print("Error reading or parsing the file: $e");
    return null;
  }
}

Future<A7adithModel?> getIbnmajahHadiths() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/ibnmajah.json');

    if (await file.exists()) {
      String fileContent = await file.readAsString();

      print("File content: $fileContent");

      Map<String, dynamic> jsonData = json.decode(fileContent);

      A7adithModel hadiths = A7adithModel.fromJson(jsonData);
      return hadiths;
    } else {
      print("File does not exist");
      return null;
    }
  } catch (e) {
    print("Error reading or parsing the file: $e");
    return null;
  }
}

Future<A7adithModel?> getMalikHadiths() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/malik.json');

    if (await file.exists()) {
      String fileContent = await file.readAsString();

      print("File content: $fileContent");

      Map<String, dynamic> jsonData = json.decode(fileContent);

      A7adithModel hadiths = A7adithModel.fromJson(jsonData);
      return hadiths;
    } else {
      print("File does not exist");
      return null;
    }
  } catch (e) {
    print("Error reading or parsing the file: $e");
    return null;
  }
}

Future<A7adithModel?> getdarimiHadiths() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/darimi.json');

    if (await file.exists()) {
      String fileContent = await file.readAsString();

      print("File content: $fileContent");

      Map<String, dynamic> jsonData = json.decode(fileContent);

      A7adithModel hadiths = A7adithModel.fromJson(jsonData);
      return hadiths;
    } else {
      print("File does not exist");
      return null;
    }
  } catch (e) {
    print("Error reading or parsing the file: $e");
    return null;
  }
}

Future<A7adithModel?> getahmedHadiths() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/ahmed.json');

    if (await file.exists()) {
      String fileContent = await file.readAsString();

      print("File content: $fileContent");

      Map<String, dynamic> jsonData = json.decode(fileContent);

      A7adithModel hadiths = A7adithModel.fromJson(jsonData);
      return hadiths;
    } else {
      print("File does not exist");
      return null;
    }
  } catch (e) {
    print("Error reading or parsing the file: $e");
    return null;
  }
}
