import '../../bussiness_logic/notification_cubit.dart';

class NotificationRepo {
  static List<Map<String, dynamic>> fajr = [
    {
      "title": "احمد الطرابلسي",
      "value": "احمد الطرابلسي",
      "onChanged": (String? value)async {
        NotificationCubit().changeSoundState(fajarAlarmSound: value);
        await NotificationCubit().playAlarmSound("ahmed_eltrabolsy_fajr");
      },
    },
    {
      "title": "عبد الباسط عبد الصمد",
      "value": "عبد الباسط عبد الصمد",
      "onChanged": (String? value) async {
        NotificationCubit().changeSoundState(fajarAlarmSound: value);
          await NotificationCubit().playAlarmSound("abdelbassit_fajr");
      },
    },
    {
      "title": "مشاري راشد العفاسي",
      "value": "مشاري راشد العفاسي",
      "onChanged": (String? value) async {
        NotificationCubit().changeSoundState(fajarAlarmSound: value);
          await NotificationCubit().playAlarmSound("mashari_rashed_fajr");
      },
    },
  ];

//============================================

  static List<Map<String, dynamic>> generateSoundList(
      String prayerName, Map<String, String> soundFiles) {
    return soundFiles.entries.map((entry) {
      return {
        "title": entry.key,
        "value": entry.key,
        "onChanged": (String? value) async {
          NotificationCubit().changeSoundState(
            duharAlarmSound: prayerName == "duhar" ? value : null,
            asrAlarmSound: prayerName == "asr" ? value : null,
            maghribAlarmSound: prayerName == "maghrib" ? value : null,
            ishaAlarmSound: prayerName == "isha" ? value : null,
          );

          // تشغيل الصوت لجميع الصلوات
          await NotificationCubit().playAlarmSound(entry.value);
        },
      };
    }).toList();
  }

// أسماء القراء والمسارات الصوتية
  static const Map<String, String> soundFiles = {
    "علي بن احمد الملا": "ali_elmola",
    "عبد الباسط عبد الصمد": "abdelbassit",
    "مشاري راشد العفاسي": "mashari_rashed",
    "محمد صديق المنشاوي": "saddik_menshawy",
    "محمد رفعت": "mohamed_rafeat",
    "مصطفي اسماعيل": "mostafa_esmail",
    "ناصر القطامي": "nasser_katamii",
  };

// إنشاء القوائم لكل صلاة
 


  

//===================================================

  static List<Map<String, dynamic>> radioTileList(String prayerName) {
    late List<Map<String, dynamic>> prayerRadioList;

    switch (prayerName) {
      case "الفجر":
        prayerRadioList = fajr;
        break;
      case "الظهر":

       final List<Map<String, dynamic>> duhar = generateSoundList("duhar", soundFiles);
        prayerRadioList = duhar;
        break;
      case "العصر":

      
  final List<Map<String, dynamic>> asr = generateSoundList("asr", soundFiles);
        prayerRadioList = asr;
        break;
      case "المغرب":
        final List<Map<String, dynamic>> maghrib = generateSoundList("maghrib", soundFiles);
        prayerRadioList = maghrib;
        break;
      case "العشاء":

      final List<Map<String, dynamic>> isha = generateSoundList("isha", soundFiles);
        prayerRadioList = isha;
        break;
      default:
    }

    return prayerRadioList;
  }
}
