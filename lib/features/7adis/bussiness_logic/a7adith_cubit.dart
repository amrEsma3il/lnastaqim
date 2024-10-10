import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/hadith_service/hadith_service.dart';
import '../data/model/a7adith_model.dart';
import 'a7adiths_state.dart';

class HadithCubit extends Cubit<HadithState> {
  HadithCubit() : super(HadithInitial());

  Future<void> bukhariHadithsCubit(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission();

    if (permissionGranted) {
      try {
        emit(HadithLoading());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool fileExists = prefs.getBool('fileExists') ?? false;
        log(fileExists.toString());
        if (!fileExists) {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/bukhari.json",
            "bukhari.json",
            onProgress: (progress) {
              print("Download progress: $progress");
              emit(HadithDownloadProgress(progress));
            },
          );
          await prefs.setBool('fileExists', true);
        }
        A7adithModel? hadiths = await getBukhariHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
    } else {
      emit(HadithError("Storage permission is required to download Hadiths"));
    }
  }

  Future<void> muslimHadithsCubit(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission();

    if (permissionGranted) {
      try {
        emit(HadithLoading());
        SharedPreferences muslimPref = await SharedPreferences.getInstance();
        bool fileMuslimExists = muslimPref.getBool('muslimHadith') ?? false;
        log(fileMuslimExists.toString());

        if (!fileMuslimExists) {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/muslim.json",
            "muslim.json",
            onProgress: (progress) {
              print("Download progress: $progress");
              emit(HadithDownloadProgress(progress));
            },
          );
          await muslimPref.setBool('muslimHadith', true);
        }
        A7adithModel? hadiths = await getMuslimHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
    } else {
      emit(HadithError("Storage permission is required to download Hadiths"));
    }
  }

  Future<void> abuDawudHadithsCubit(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission();

    if (permissionGranted) {
      try {
        emit(HadithLoading());
        SharedPreferences abuDawudPrefs = await SharedPreferences.getInstance();
        bool fileAbuDawudExists =
            abuDawudPrefs.getBool('abudawudHadith') ?? false;
        log(fileAbuDawudExists.toString());

        if (!fileAbuDawudExists) {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/abudawud.json",
            "abudawud.json",
            onProgress: (progress) {
              print("Download progress: $progress");
              emit(HadithDownloadProgress(progress));
            },
          );
          await abuDawudPrefs.setBool('abudawudHadith', true);
        }
        A7adithModel? hadiths = await getAbuDawudHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
    } else {
      emit(HadithError("Storage permission is required to download Hadiths"));
    }
  }

  Future<void> tirmidhiHadithsCubit(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission();

    if (permissionGranted) {
      try {
        emit(HadithLoading());
        SharedPreferences tirmidhiPrefs = await SharedPreferences.getInstance();
        bool filetirmidhiExists =
            tirmidhiPrefs.getBool('tirmidhiHadith') ?? false;
        log(filetirmidhiExists.toString());

        if (!filetirmidhiExists) {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/tirmidhi.json",
            "tirmidhi.json",
            onProgress: (progress) {
              print("Download progress: $progress");
              emit(HadithDownloadProgress(progress));
            },
          );
          await tirmidhiPrefs.setBool('tirmidhiHadith', true);
        }
        A7adithModel? hadiths = await getTirmidhiHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
    } else {
      emit(HadithError("Storage permission is required to download Hadiths"));
    }
  }

  Future<void> nasaiHadithsCubit(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission();

    if (permissionGranted) {
      try {
        emit(HadithLoading());
        SharedPreferences nasaiPrefs = await SharedPreferences.getInstance();
        bool filenasaiExists = nasaiPrefs.getBool('nasaiHadith') ?? false;
        log(filenasaiExists.toString());

        if (!filenasaiExists) {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/nasai.json",
            "nasai.json",
            onProgress: (progress) {
              print("Download progress: $progress");
              emit(HadithDownloadProgress(progress));
            },
          );
          await nasaiPrefs.setBool('nasaiHadith', true);
        }
        A7adithModel? hadiths = await getNasaiHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
    } else {
      emit(HadithError("Storage permission is required to download Hadiths"));
    }
  }

  Future<void> ibnmajahHadithsCubit(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission();

    if (permissionGranted) {
      try {
        emit(HadithLoading());
        SharedPreferences ibnmajahPrefs = await SharedPreferences.getInstance();
        bool fileibnmajahExists =
            ibnmajahPrefs.getBool('ibnmajahHadith') ?? false;
        log(fileibnmajahExists.toString());

        if (!fileibnmajahExists) {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/ibnmajah.json",
            "ibnmajah.json",
            onProgress: (progress) {
              print("Download progress: $progress");
              emit(HadithDownloadProgress(progress));
            },
          );
          await ibnmajahPrefs.setBool('ibnmajahHadith', true);
        }
        A7adithModel? hadiths = await getIbnmajahHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
    } else {
      emit(HadithError("Storage permission is required to download Hadiths"));
    }
  }

  Future<void> malikHadithsCubit(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission();

    if (permissionGranted) {
      try {
        emit(HadithLoading());
        SharedPreferences malikPrefs = await SharedPreferences.getInstance();
        bool filemalikExists = malikPrefs.getBool('malikHadith') ?? false;
        log(filemalikExists.toString());

        if (!filemalikExists) {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/malik.json",
            "malik.json",
            onProgress: (progress) {
              print("Download progress: $progress");
              emit(HadithDownloadProgress(progress));
            },
          );
          await malikPrefs.setBool('malikHadith', true);
        }
        A7adithModel? hadiths = await getMalikHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
    } else {
      emit(HadithError("Storage permission is required to download Hadiths"));
    }
  }

  Future<void> darimiHadithsCubit(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission();

    if (permissionGranted) {
      try {
        emit(HadithLoading());
        SharedPreferences darimiPrefs = await SharedPreferences.getInstance();
        bool filedarimiExists = darimiPrefs.getBool('darimiHadith') ?? false;
        log(filedarimiExists.toString());

        if (!filedarimiExists) {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/darimi.json",
            "darimi.json",
            onProgress: (progress) {
              print("Download progress: $progress");
              emit(HadithDownloadProgress(progress));
            },
          );
          await darimiPrefs.setBool('darimiHadith', true);
        }
        A7adithModel? hadiths = await getdarimiHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
    } else {
      emit(HadithError("Storage permission is required to download Hadiths"));
    }
  }

  Future<void> ahmedHadithsCubit(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission();

    if (permissionGranted) {
      try {
        emit(HadithLoading());
        SharedPreferences ahmedPrefs = await SharedPreferences.getInstance();
        bool fileahmedExists = ahmedPrefs.getBool('ahmedHadith') ?? false;
        log(fileahmedExists.toString());

        if (!fileahmedExists) {
          await downloadHadithFiles(
            "https://raw.githubusercontent.com/AhmedBaset/hadith-json/main/db/by_book/the_9_books/ahmed.json",
            "ahmed.json",
            onProgress: (progress) {
              print("Download progress: $progress");
              emit(HadithDownloadProgress(progress));
            },
          );
          await ahmedPrefs.setBool('ahmedHadith', true);
        }
        A7adithModel? hadiths = await getahmedHadiths();

        if (hadiths != null) {
          emit(HadithLoaded([hadiths]));
        } else {
          emit(HadithError("No Hadiths found"));
        }
      } catch (e) {
        emit(HadithError("Failed to download or load Hadiths: $e"));
      }
    } else {
      emit(HadithError("Storage permission is required to download Hadiths"));
    }
  }
}
