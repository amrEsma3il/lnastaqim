import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/hadith_service/hadith_service.dart';
import '../data/model/a7adith_model.dart';
import 'a7adiths_state.dart';

class HadithCubit extends Cubit<HadithState> {
  HadithCubit() : super(HadithInitial()){
     HadithDownloadProgress.initial() ;
  }

   double progressBukhari=0;
    double progressMuslim=0;
    double progressAbuDawud=0;
    double progressTirmidhi=0;
    double progressNasai=0;
    double progressIbnmajah=0;
    double progressMalik=0;
    double progressDarimi=0;
    double progressAhmed=0;

   
Future<void> bukhariHadithsCubit(BuildContext context) async {
   emit(HadithLoading());
  try {
   
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool fileExists = prefs.getBool('bukhariHadith') ?? false;

    log("Bukhari file exists: $fileExists");
    log("Bukhari progress: $progressBukhari");

    if (!fileExists && progressBukhari == 0) {
      await downloadHadithFiles(
        "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/bukhari.json",
        "bukhari.json",
        onProgress: (progress) async {
          print("Download progress: $progress");

          // حفظ progress في SharedPreferences لمنع إعادة التحميل من الصفر
         progressBukhari=progress;

          if (state is HadithDownloadProgress) {
            emit((state as HadithDownloadProgress).copyWith(progressBukhari: progress));
          } else {
            emit(HadithDownloadProgress.initial().copyWith(progressBukhari: progress));
          }
        },
      );

      // عند انتهاء التحميل، نحفظ الملف كأنه موجود ونضبط progress على 100%
      await prefs.setBool('bukhariHadith', true);
progressBukhari=100;    }
  emit(HadithLoading());  
    A7adithModel? hadiths = await getBukhariHadiths();
    if (hadiths != null) {
      emit(HadithLoaded([hadiths]));
    } else {
      emit(HadithError("No Hadiths found"));
    }
  } catch (e) {
    emit(HadithError("Failed to download or load Hadiths: $e"));
  }
}
  Future<void> muslimHadithsCubit(BuildContext context) async {
    // bool permissionGranted = await requestStoragePermission();

  emit(HadithLoading());  
      try {
        
        SharedPreferences muslimPref = await SharedPreferences.getInstance();
        bool fileMuslimExists = muslimPref.getBool('muslimHadith') ?? false;
        log(fileMuslimExists.toString());
  


    if (!fileMuslimExists && progressMuslim == 0) {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/muslim.json",
            "muslim.json",
            onProgress: (progress) {
          print("Download progress: $progress");
          progressMuslim=progress;
          if (state is HadithDownloadProgress) {
            // استخدام copyWith لتحديث progressIbnmajah فقط
            emit((state as HadithDownloadProgress).copyWith(progressMuslim: progress));
          } else {
            // إنشاء حالة جديدة من HadithDownloadProgress بالقيم الابتدائية مع تحديث progressIbnmajah
            emit(HadithDownloadProgress.initial().copyWith(progressMuslim: progress));
          }
        },
          );
          await muslimPref.setBool('muslimHadith', true);
            progressMuslim=100;
        }
// TODO: ADD LOADING STATE
          emit(HadithLoading());  
        A7adithModel? hadiths = await getMuslimHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
    // } else {
    //   emit(HadithError("Storage permission is required to download Hadiths"));
    // }
  }

  Future<void> abuDawudHadithsCubit(BuildContext context) async {
emit(HadithLoading());
      try {
        SharedPreferences abuDawudPrefs = await SharedPreferences.getInstance();
        bool fileAbuDawudExists =
            abuDawudPrefs.getBool('abudawudHadith') ?? false;
        log(fileAbuDawudExists.toString());


    if (!fileAbuDawudExists && progressAbuDawud==0)
         {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/abudawud.json",
            "abudawud.json",
            onProgress: (progress){
          print("Download progress: $progress");
          if (state is HadithDownloadProgress) {
            // استخدام copyWith لتحديث progressIbnmajah فقط
            emit((state as HadithDownloadProgress).copyWith(progressAbuDawud: progress));
          } else {
            // إنشاء حالة جديدة من HadithDownloadProgress بالقيم الابتدائية مع تحديث progressIbnmajah
            emit(HadithDownloadProgress.initial().copyWith(progressAbuDawud: progress));
          }
        },
          );
          await abuDawudPrefs.setBool('abudawudHadith', true);
          progressAbuDawud=100;
        }
          emit(HadithLoading());  
        A7adithModel? hadiths = await getAbuDawudHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
   
  }
Future<void> tirmidhiHadithsCubit(BuildContext context) async {
  emit(HadithLoading());
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    bool fileExists = prefs.getBool('tirmidhiHadith') ?? false;
 

    log("Tirmidhi file exists: $fileExists");
   

    if (!fileExists &&   progressTirmidhi==0) {
      await downloadHadithFiles(
        "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/tirmidhi.json",
        "tirmidhi.json",
        onProgress: (progress) async {
          print("Download progress: $progress");
          progressTirmidhi=progress;

          // حفظ progress في SharedPreferences لمنع إعادة التحميل من الصفر

          if (state is HadithDownloadProgress) {
            emit((state as HadithDownloadProgress).copyWith(progressTirmidhi: progress));
          } else {
            emit(HadithDownloadProgress.initial().copyWith(progressTirmidhi: progress));
          }
        },
      );
          progressTirmidhi=100;

      // عند انتهاء التحميل، نحفظ الملف كأنه موجود ونضبط progress على 100%
      await prefs.setBool('tirmidhiHadith', true);
    }
  emit(HadithLoading());  
    A7adithModel? hadiths = await getTirmidhiHadiths();
    if (hadiths != null) {
      emit(HadithLoaded([hadiths]));
    } else {
      emit(HadithError("No Hadiths found"));
    }
  } catch (e) {
    emit(HadithError("Failed to download or load Hadiths: $e"));
  }
}

Future<void> nasaiHadithsCubit(BuildContext context) async {
  emit(HadithLoading());
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    bool fileExists = prefs.getBool('nasaiHadith') ?? false;

    log("Nasai file exists: $fileExists");

    if (!fileExists &&   progressNasai==0) {
      await downloadHadithFiles(
        "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/nasai.json",
        "nasai.json",
        onProgress: (progress) async {
          print("Download progress: $progress");

          // حفظ progress في SharedPreferences لمنع إعادة التحميل من الصفر
          progressNasai=progress;

          if (state is HadithDownloadProgress) {
            emit((state as HadithDownloadProgress).copyWith(progressNasai: progress));
          } else {
            emit(HadithDownloadProgress.initial().copyWith(progressNasai: progress));
          }
        },
      );

      // عند انتهاء التحميل، نحفظ الملف كأنه موجود ونضبط progress على 100%
      await prefs.setBool('nasaiHadith', true);
          progressNasai=100;
    }
  emit(HadithLoading());  
    A7adithModel? hadiths = await getNasaiHadiths();
    if (hadiths != null) {
      emit(HadithLoaded([hadiths]));
    } else {
      emit(HadithError("No Hadiths found"));
    }
  } catch (e) {
    emit(HadithError("Failed to download or load Hadiths: $e"));
  }
}


Future<void> ibnmajahHadithsCubit(BuildContext context) async {
  emit(HadithLoading());
  try {
   
    SharedPreferences ibnmajahPrefs = await SharedPreferences.getInstance();
    bool fileibnmajahExists = ibnmajahPrefs.getBool('ibnmajahHadith') ?? false;
    log(fileibnmajahExists.toString());


    if (!fileibnmajahExists &&progressIbnmajah==0) {
      await downloadHadithFiles(
        "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/ibnmajah.json",
        "ibnmajah.json",
        onProgress: (progress) {
                    progressIbnmajah=progress;

          print("Download progress: $progress");
          if (state is HadithDownloadProgress) {
            // استخدام copyWith لتحديث progressIbnmajah فقط
            emit((state as HadithDownloadProgress).copyWith(progressIbnmajah: progress));
          } else {
            // إنشاء حالة جديدة من HadithDownloadProgress بالقيم الابتدائية مع تحديث progressIbnmajah
            emit(HadithDownloadProgress.initial().copyWith(progressIbnmajah: progress));
          }
        },
      );
      await ibnmajahPrefs.setBool('ibnmajahHadith', true);
                progressIbnmajah=100;

    }
  emit(HadithLoading());  
    A7adithModel? hadiths = await getIbnmajahHadiths();

    if (hadiths != null) {
      emit(HadithLoaded([hadiths]));
    } else {
      emit(HadithError("No Hadiths found"));
    }
  } catch (e) {
    emit(HadithError("Failed to download or load Hadiths: $e"));
  }
}


Future<void> malikHadithsCubit(BuildContext context) async {
     emit(HadithLoading());
  try {
 
    SharedPreferences malikPrefs = await SharedPreferences.getInstance();
    bool filemalikExists = malikPrefs.getBool('malikHadith') ?? false;
    log(filemalikExists.toString());

   

    if (!filemalikExists && progressMalik==0) {
      await downloadHadithFiles(
        "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/malik.json",
        "malik.json",
        onProgress: (progress) {
                    progressMalik=progress;

          print("Download progress: $progress");
          if (state is HadithDownloadProgress) {
            // تحديث progressMalik فقط باستخدام copyWith
            emit((state as HadithDownloadProgress).copyWith(progressMalik: progress));
          } else {
            // إنشاء حالة جديدة مع تحديث progressMalik فقط
            emit(HadithDownloadProgress.initial().copyWith(progressMalik: progress));
          }
        },
      );
      await malikPrefs.setBool('malikHadith', true);
                progressMalik=100;

    }
  emit(HadithLoading());  
    A7adithModel? hadiths = await getMalikHadiths();

    if (hadiths != null) {
      emit(HadithLoaded([hadiths]));
    } else {
      emit(HadithError("No Hadiths found"));
    }
  } catch (e) {
    emit(HadithError("Failed to download or load Hadiths: $e"));
  }
}

Future<void> darimiHadithsCubit(BuildContext context) async {
  emit(HadithLoading());
  try {
   
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool fileExists = prefs.getBool('darimiHadith') ?? false;
  

    log("Darimi file exists: $fileExists");
 

    if (!fileExists &&  progressDarimi==0) {
      await downloadHadithFiles(
        "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/darimi.json",
        "darimi.json",
        onProgress: (progress) async {
          print("Download progress: $progress");

          // حفظ progress في SharedPreferences لمنع إعادة التحميل من الصفر
                    progressDarimi=progress;


          if (state is HadithDownloadProgress) {
            emit((state as HadithDownloadProgress).copyWith(progressDarimi: progress));
          } else {
            emit(HadithDownloadProgress.initial().copyWith(progressDarimi: progress));
          }
        },
      );

      // عند انتهاء التحميل، نحفظ الملف كأنه موجود ونضبط progress على 100%
      await prefs.setBool('darimiHadith', true);
                progressDarimi=100;

    }
  emit(HadithLoading());  
    A7adithModel? hadiths = await getdarimiHadiths();
    if (hadiths != null) {
      emit(HadithLoaded([hadiths]));
    } else {
      emit(HadithError("No Hadiths found"));
    }
  } catch (e) {
    emit(HadithError("Failed to download or load Hadiths: $e"));
  }
}

Future<void> ahmedHadithsCubit(BuildContext context) async {
  emit(HadithLoading());
  try {
    
    SharedPreferences ahmedPrefs = await SharedPreferences.getInstance();
    bool fileAhmedExists = ahmedPrefs.getBool('ahmedHadith') ?? false;
    log(fileAhmedExists.toString());


    if (!fileAhmedExists && progressAhmed == 0) {
      
     
      await downloadHadithFiles(
        "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/ahmed.json",
        "ahmed.json",
        onProgress: (progress) {
                    progressAhmed=progress;

          print("Download progress: $progress");
          if (state is HadithDownloadProgress) {
            emit((state as HadithDownloadProgress).copyWith(progressAhmed: progress));
          } else {
            emit(HadithDownloadProgress.initial().copyWith(progressAhmed: progress));
          }
        },
      );
      await ahmedPrefs.setBool('ahmedHadith', true);
                progressAhmed=100;

    }
  emit(HadithLoading());  
    A7adithModel? hadiths = await getahmedHadiths();

    if (hadiths != null) {
      emit(HadithLoaded([hadiths]));
    } else {
      emit(HadithError("No Hadiths found"));
    }
  } catch (e) {
    emit(HadithError("Failed to download or load Hadiths: $e"));
  }
}


}
