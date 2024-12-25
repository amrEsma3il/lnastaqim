
// import 'dart:developer';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path_provider/path_provider.dart';

// import 'font_loader_test.dart';

// class FontCubit extends Cubit<String> {

// FontCubit():super("604");


// static FontCubit getFontCubit(BuildContext context)=>BlocProvider.of(context);

// loadFont(int page)async{

// emit("waiting");

// String pageNum=(page).toString().padLeft(3,'0');
// await FontService.getfontServiceInstance().loadFont(pageNum);


// log("from state${pageNum}");
// emit("quran_font_$pageNum");
// //  final directory = await getApplicationDocumentsDirectory();
  
// //   // تحديد المجلد المستهدف (يمكنك تغييره حسب الحاجة)
// //   final targetDirectory = Directory('${directory.path}/fonts');

// //   // التحقق من وجود المجلد
// //   if (await targetDirectory.exists()) {
// //     // الحصول على قائمة الملفات
// // log("فولدر الفونتات موجود بالفعل");
// //     // طباعة المسارات
    
// //   } else {
// //    log("يبضاني الفولدر مش موجود");

// //   }
// }

// Future<void> listFilesInDirectory() async {
//   // الحصول على مسار التخزين الداخلي للتطبيق
//   final directory = await getApplicationDocumentsDirectory();
  
//   // تحديد المجلد المستهدف (يمكنك تغييره حسب الحاجة)
//   final targetDirectory = Directory('${directory.path}/fonts');

//   // التحقق من وجود المجلد
// try {
//     if (await targetDirectory.exists()) {
//     // الحصول على قائمة الملفات
//     List<FileSystemEntity> files = targetDirectory.listSync();

//     // طباعة المسارات

//       log('File1 path: ${files[0].path}');
   


//     log('Directory is found!');
//   } else {
//     log('Directory not found!');
//   }
// } catch (e) {
//   log("خطا");
//   log(e.toString());
// }
// }
// }