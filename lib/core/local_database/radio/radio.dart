// 20240806002632
// https://mp3quran.net/api/v3/radios?language=ar

class RadioDatabase {
  
static List<Map<String, dynamic>> quranSowar = [
    {
      "id": 1,
      "name": "إذاعة إبراهيم الأخضر",
      "url": "https://backup.qurango.net/radio/ibrahim_alakdar",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 10,
      "name": "إذاعة القارئ ياسين",
      "url": "https://backup.qurango.net/radio/alqaria_yassen",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 100,
      "name": " إذاعة أحمد الطرابلسي",
      "url": "https://backup.qurango.net/radio/ahmed_altrabulsi",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 101,
      "name": " إذاعة عبدالله الكندري",
      "url": "https://backup.qurango.net/radio/abdullah_alkandari",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 102,
      "name": " إذاعة أحمد عامر",
      "url": "https://backup.qurango.net/radio/ahmed_amer",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 103,
      "name": "إذاعة محمد عثمان خان",
      "url": "https://backup.qurango.net/radio/mohammed_osman_khan",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 104,
      "name": " إذاعة الدوكالي محمد العالم",
      "url": "https://backup.qurango.net/radio/addokali_mohammad_alalim",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 105,
      "name": " إذاعة محمد عبدالكريم",
      "url": "https://backup.qurango.net/radio/mohammad_abdullkarem_alasbahani",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 106,
      "name": " إذاعة الفاتح محمد الزبير",
      "url": "https://backup.qurango.net/radio/alfateh_alzubair",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 107,
      "name": " إذاعة طارق عبدالغني دعوب",
      "url": "https://backup.qurango.net/radio/tareq_abdulgani_daawob",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 108,
      "name": "-الإذاعة العامة - اذاعة متنوعة لمختلف القراء",
      "url": "https://backup.qurango.net/radio/mix",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 109,
      "name": "إذاعة -تلاوات خاشعة-",
      "url": "https://backup.qurango.net/radio/salma",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 10902,
      "name": "آيات السكينة",
      "url": "https://backup.qurango.net/radio/sakeenah",
      "recent_date": "2020-07-17 08:39:15"
    },
    {
      "id": 10903,
      "name": "---إذاعة صور من حياة الصحابة والتابعين رضوان الله عليهم---",
      "url": "https://backup.qurango.net/radio/sahabah",
      "recent_date": "2020-07-17 08:40:45"
    },
    {
      "id": 109038,
      "name": "صالح الهبدان",
      "url": "https://backup.qurango.net/radio/saleh_alhabdan",
      "recent_date": "2020-06-26 19:47:04"
    },
    {
      "id": 10904,
      "name": "المختصر في تفسير القرآن الكريم",
      "url": "https://backup.qurango.net/radio/mukhtasartafsir",
      "recent_date": "2021-03-25 11:28:18"
    },
    {
      "id": 10906,
      "name": "أذكار الصباح",
      "url": "https://backup.qurango.net/radio/athkar_sabah",
      "recent_date": "2021-08-27 06:48:42"
    },
    {
      "id": 109060,
      "name": "سورة الملك",
      "url": "https://backup.qurango.net/radio/Surah_Al-Mulk",
      "recent_date": "2024-04-12 23:32:01"
    },
    {
      "id": 10907,
      "name": "أذكار المساء",
      "url": "https://backup.qurango.net/radio/athkar_masa",
      "recent_date": "2021-08-27 06:49:07"
    },
    {
      "id": 11,
      "name": "إذاعة العيون الكوشي",
      "url": "https://backup.qurango.net/radio/aloyoon_alkoshi",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 110,
      "name": "إذاعة تكبيرات العيد",
      "url": "https://backup.qurango.net/radio/eid",
      "recent_date": "2020-06-26 20:41:26"
    },
    {
      "id": 111,
      "name": " إذاعة عبدالرحمن الماجد",
      "url": "https://backup.qurango.net/radio/abdulrahman_almajed",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 113,
      "name": "إذاعة الفتاوى العامة",
      "url": "https://backup.qurango.net/radio/fatwa",
      "recent_date": "2020-06-26 20:39:55"
    },
    {
      "id": 114,
      "name": "إذاعة الرقية الشرعية",
      "url": "https://backup.qurango.net/radio/roqiah",
      "recent_date": "2020-06-26 20:38:21"
    },
    {
      "id": 115,
      "name": "إذاعة ---سورة البقرة - لعدد من القراء---",
      "url": "https://backup.qurango.net/radio/albaqarah",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 116,
      "name": "إذاعة --تفسير القران الكريم--",
      "url": "https://backup.qurango.net/radio/tafseer",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 117,
      "name": "إذاعة خالد الجليل",
      "url": "https://backup.qurango.net/radio/khalid_aljileel",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 118,
      "name": "إذاعة ناصر الماجد",
      "url": "https://backup.qurango.net/radio/nasser_almajed",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 119,
      "name": "إذاعة هيثم الجدعاني",
      "url": "https://backup.qurango.net/radio/hitham_aljadani",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 12,
      "name": "إذاعة توفيق الصايغ",
      "url": "https://backup.qurango.net/radio/tawfeeq_assayegh",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 120,
      "name": "إذاعة أحمد خليل شاهين",
      "url": "https://backup.qurango.net/radio/ahmad_shaheen",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 121,
      "name": "إذاعة عبدالله الموسى",
      "url": "https://backup.qurango.net/radio/abdullah_almousa",
      "recent_date": "2020-06-26 20:46:31"
    },
    {
      "id": 122,
      "name": "إذاعة عبدالله الخلف",
      "url": "https://backup.qurango.net/radio/abdullah_alkhalaf",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 123,
      "name": "---تراتيل قصيرة متميزة---",
      "url": "https://backup.qurango.net/radio/tarateel",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 13,
      "name": "إذاعة جمال شاكر عبدالله",
      "url": "https://backup.qurango.net/radio/jamal_shaker_abdullah",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 139,
      "name": "إذاعة ماجد الزامل",
      "url": "https://backup.qurango.net/radio/majed_alzamel",
      "recent_date": "2020-06-26 19:43:46"
    },
    {
      "id": 14,
      "name": "إذاعة خالد القحطاني",
      "url": "https://backup.qurango.net/radio/khaled_alqahtani",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 15,
      "name": "إذاعة خالد عبدالكافي",
      "url": "https://backup.qurango.net/radio/khalid_abdulkafi",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 16,
      "name": "إذاعة خليفة الطنيجي",
      "url": "https://backup.qurango.net/radio/khalifa_altunaiji",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 17,
      "name": "إذاعة سعد الغامدي",
      "url": "https://backup.qurango.net/radio/saad_alghamdi",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 18,
      "name": "إذاعة سعود الشريم",
      "url": "https://backup.qurango.net/radio/saud_alshuraim",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 19,
      "name": "إذاعة سهل ياسين",
      "url": "https://backup.qurango.net/radio/sahl_yassin",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 2,
      "name": "إذاعة شيخ أبو بكر الشاطري",
      "url": "https://backup.qurango.net/radio/shaik_abu_bakr_al_shatri",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 20,
      "name": "إذاعة زكي داغستاني",
      "url": "https://backup.qurango.net/radio/zaki_daghistani",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 21,
      "name": "إذاعة سيد رمضان",
      "url": "https://backup.qurango.net/radio/sayeed_ramadan",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 21114,
      "name": "في ظلال السيرة النبوية - 400 حلقة عن سيرة نبينا محمد صلى الله عليه وسلم",
      "url": "https://backup.qurango.net/radio/fi_zilal_alsiyra",
      "recent_date": "2021-09-26 19:36:41"
    },
    {
      "id": 21116,
      "name": "كتاب الاختيارات الفقهية في مسائل العبادات والمعاملات من فتاوى الشيخ ابن باز",
      "url": "https://backup.qurango.net/radio/alaikhtiarat_alfiqhayh_bin_baz",
      "recent_date": "2022-02-13 17:48:06"
    },
    {
      "id": 21117,
      "name": "تفسير القران الكريم-الخلاصة من تفسير الطبري",
      "url": "https://backup.qurango.net/radio/tabri",
      "recent_date": "2023-12-02 14:42:00"
    },
    {
      "id": 217,
      "name": "إذاعة بندر بليلة",
      "url": "https://backup.qurango.net/radio/bandar_balilah",
      "recent_date": "2021-09-06 16:14:27"
    },
    {
      "id": 22,
      "name": "إذاعة شيرزاد عبدالرحمن طاهر",
      "url": "https://backup.qurango.net/radio/shirazad_taher",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 23,
      "name": "إذاعة صابر عبدالحكم",
      "url": "https://backup.qurango.net/radio/saber_abdulhakm",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 24,
      "name": "إذاعة صلاح البدير",
      "url": "https://backup.qurango.net/radio/salah_albudair",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 248,
      "name": "إذاعة ناصر العصفور",
      "url": "https://backup.qurango.net/radio/nasser_alosfor",
      "recent_date": "2020-05-04 20:27:02"
    },
    {
      "id": 25,
      "name": "إذاعة صلاح الهاشم",
      "url": "https://backup.qurango.net/radio/salah_alhashim",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 26,
      "name": "إذاعة صلاح بو خاطر",
      "url": "https://backup.qurango.net/radio/slaah_bukhatir",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 261,
      "name": "إذاعة محمد أيوب - قراءة متميزة-",
      "url": "https://backup.qurango.net/radio/ayyoub2",
      "recent_date": "2020-06-26 20:35:33"
    },
    {
      "id": 265,
      "name": "إذاعة أحمد ديبان",
      "url": "https://backup.qurango.net/radio/ahmad_deban",
      "recent_date": "2020-06-26 19:46:13"
    },
    {
      "id": 27,
      "name": "إذاعة عادل ريان",
      "url": "https://backup.qurango.net/radio/adel_ryyan",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 274,
      "name": "أذاعة محمد أبوسنينة",
      "url": "https://backup.qurango.net/radio/sneineh",
      "recent_date": "2022-08-17 10:40:49"
    },
    {
      "id": 275,
      "name": "إذاعة محمد الأمين قنيوة",
      "url": "https://backup.qurango.net/radio/qeniwa",
      "recent_date": "2022-08-17 10:44:08"
    },
    {
      "id": 28,
      "name": "إذاعة عبدالبارئ الثبيتي",
      "url": "https://backup.qurango.net/radio/abdelbari_altoubayti",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 287,
      "name": "إذاعة عبدالرحمن الشحات",
      "url": "https://backup.qurango.net/radio/a_alshahhat",
      "recent_date": "2022-09-20 11:28:01"
    },
    {
      "id": 29,
      "name": "إذاعة عبدالبارئ محمد",
      "url": "https://backup.qurango.net/radio/abdulbari_mohammad",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 3,
      "name": "إذاعة أحمد العجمي",
      "url": "https://backup.qurango.net/radio/ahmad_alajmy",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 30,
      "name": "إذاعة عبدالباسط عبدالصمد",
      "url": "https://backup.qurango.net/radio/abdulbasit_abdulsamad_mojawwad",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 307,
      "name": "عبدالعزيز سحيم",
      "url": "https://backup.qurango.net/radio/a_sheim",
      "recent_date": "2023-10-10 22:18:00"
    },
    {
      "id": 31,
      "name": "إذاعة عبدالباسط عبدالصمد",
      "url": "https://backup.qurango.net/radio/abdulbasit_abdulsamad_warsh",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 32,
      "name": "إذاعة عبدالباسط عبدالصمد",
      "url": "https://backup.qurango.net/radio/abdulbasit_abdulsamad",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 33,
      "name": "إذاعة عبدالرحمن السديس",
      "url": "https://backup.qurango.net/radio/abdulrahman_alsudaes",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 34,
      "name": "إذاعة عبدالعزيز الأحمد",
      "url": "https://backup.qurango.net/radio/abdul_aziz_alahmad",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 35,
      "name": "إذاعة عبدالله المطرود",
      "url": "https://backup.qurango.net/radio/abdullah_almattrod",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 36,
      "name": "إذاعة عبدالله بصفر",
      "url": "https://backup.qurango.net/radio/abdullah_basfer",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 37,
      "name": "إذاعة عبدالله خياط",
      "url": "https://backup.qurango.net/radio/abdullah_khayyat",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 38,
      "name": "إذاعة عبدالله عواد الجهني",
      "url": "https://backup.qurango.net/radio/abdullah_aljohany",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 39,
      "name": "إذاعة عبدالرشيد صوفي",
      "url": "https://backup.qurango.net/radio/abdulrasheed_soufi_khalaf",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 4,
      "name": "إذاعة أحمد الحواشي",
      "url": "https://backup.qurango.net/radio/ahmad_alhawashi",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 40,
      "name": "إذاعة عبدالرشيد صوفي",
      "url": "https://backup.qurango.net/radio/abdulrasheed_soufi_assosi",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 41,
      "name": "إذاعة عبدالمحسن الحارثي",
      "url": "https://backup.qurango.net/radio/abdulmohsin_alharthy",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 42,
      "name": "إذاعة عبدالمحسن القاسم",
      "url": "https://backup.qurango.net/radio/abdulmohsen_alqasim",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 43,
      "name": "إذاعة عبدالمحسن العبيكان",
      "url": "https://backup.qurango.net/radio/abdulmohsin_alobaikan",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 44,
      "name": "إذاعة عبدالهادي أحمد كناكري",
      "url": "https://backup.qurango.net/radio/abdulhadi_kanakeri",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 45,
      "name": "إذاعة عبدالودود حنيف",
      "url": "https://backup.qurango.net/radio/abdulwadood_haneef",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 46,
      "name": "إذاعة علي بن عبدالرحمن الحذيفي",
      "url": "https://backup.qurango.net/radio/ali_alhuthaifi",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 47,
      "name": "إذاعة علي الحذيفي",
      "url": "https://backup.qurango.net/radio/ali_alhuthaifi_qalon",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 48,
      "name": " إذاعة علي جابر",
      "url": "https://backup.qurango.net/radio/ali_jaber",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 49,
      "name": " إذاعة علي حجاج السويسي",
      "url": "https://backup.qurango.net/radio/ali_hajjaj_alsouasi",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 5,
      "name": "إذاعة أحمد صابر",
      "url": "https://backup.qurango.net/radio/ahmad_saber",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 50,
      "name": " إذاعة عماد زهير حافظ",
      "url": "https://backup.qurango.net/radio/emad_hafez",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 51,
      "name": " إذاعة عمر القزابري",
      "url": "https://backup.qurango.net/radio/omar_alqazabri",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 52,
      "name": " إذاعة فارس عباد",
      "url": "https://backup.qurango.net/radio/fares_abbad",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 53,
      "name": " إذاعة ناصر القطامي",
      "url": "https://backup.qurango.net/radio/nasser_alqatami",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 54,
      "name": " إذاعة نبيل الرفاعي",
      "url": "https://backup.qurango.net/radio/nabil_al_rifay",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 55,
      "name": " إذاعة نعمة الحسان",
      "url": "https://backup.qurango.net/radio/neamah_alhassan",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 56,
      "name": " إذاعة هاني الرفاعي",
      "url": "https://backup.qurango.net/radio/hani_arrifai",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 57,
      "name": " إذاعة وليد النائحي",
      "url": "https://backup.qurango.net/radio/waleed_alnaehi",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 58,
      "name": " إذاعة ياسر الدوسري",
      "url": "https://backup.qurango.net/radio/yasser_aldosari",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 59,
      "name": " إذاعة ياسر القرشي",
      "url": "https://backup.qurango.net/radio/yasser_alqurashi",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 6,
      "name": "إذاعة أحمد نعينع",
      "url": "https://backup.qurango.net/radio/ahmad_nauina",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 60,
      "name": " إذاعة ياسر المزروعي ",
      "url": "https://backup.qurango.net/radio/yasser_almazroyee",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 61,
      "name": " إذاعة يحيى حوا",
      "url": "https://backup.qurango.net/radio/yahya_hawwa",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 62,
      "name": " إذاعة يوسف الشويعي",
      "url": "https://backup.qurango.net/radio/yousef_alshoaey",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 63,
      "name": " إذاعة ماهر المعيقلي",
      "url": "https://backup.qurango.net/radio/maher",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 64,
      "name": " إذاعة محمد الطبلاوي",
      "url": "https://backup.qurango.net/radio/mohammad_altablaway",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 65,
      "name": " إذاعة محمد اللحيدان",
      "url": "https://backup.qurango.net/radio/mohammed_allohaidan",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 66,
      "name": " إذاعة محمد أيوب",
      "url": "https://backup.qurango.net/radio/mohammed_ayyub",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 67,
      "name": " إذاعة محمد صالح عالم شاه",
      "url": "https://backup.qurango.net/radio/mohammad_saleh_alim_shah",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 68,
      "name": " إذاعة محمد جبريل",
      "url": "https://backup.qurango.net/radio/mohammed_jibreel",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 69,
      "name": " إذاعة محمد صديق المنشاوي",
      "url": "https://backup.qurango.net/radio/mohammed_siddiq_alminshawi",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 7,
      "name": "إذاعة أكرم العلاقمي",
      "url": "https://backup.qurango.net/radio/akram_alalaqmi",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 70,
      "name": " إذاعة محمد صديق المنشاوي",
      "url": "https://backup.qurango.net/radio/mohammed_siddiq_alminshawi_mojawwad",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 71,
      "name": " إذاعة محمد عبدالكريم",
      "url": "https://backup.qurango.net/radio/mohammad_abdullkarem",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 72,
      "name": " إذاعة محمد عبدالحكيم سعيد العبدالله",
      "url": "https://backup.qurango.net/radio/mohammad_alabdullah_albizi",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 73,
      "name": " إذاعة محمد عبدالحكيم سعيد العبدالله",
      "url": "https://backup.qurango.net/radio/mohammad_alabdullah_aldorai",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 74,
      "name": " إذاعة محمود خليل الحصري",
      "url": "https://backup.qurango.net/radio/mahmoud_khalil_alhussary",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 75,
      "name": " إذاعة محمود خليل الحصري",
      "url": "https://backup.qurango.net/radio/mahmoud_khalil_alhussary_mojawwad",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 76,
      "name": " إذاعة محمود خليل الحصري",
      "url": "https://backup.qurango.net/radio/mahmoud_khalil_alhussary_warsh",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 77,
      "name": " إذاعة محمود علي البنا",
      "url": "https://backup.qurango.net/radio/mahmoud_ali__albanna",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 78,
      "name": " إذاعة محمود علي البنا",
      "url": "https://backup.qurango.net/radio/mahmoud_ali__albanna_mojawwad",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 79,
      "name": " إذاعة مشاري العفاسي",
      "url": "https://backup.qurango.net/radio/mishary_alafasi",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 8,
      "name": "إذاعة إدريس أبكر",
      "url": "https://backup.qurango.net/radio/idrees_abkr",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 80,
      "name": " إذاعة مصطفى إسماعيل",
      "url": "https://backup.qurango.net/radio/mustafa_ismail",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 81,
      "name": " إذاعة مصطفى اللاهوني",
      "url": "https://backup.qurango.net/radio/mustafa_allahoni",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 82,
      "name": " إذاعة مصطفى رعد العزاوي",
      "url": "https://backup.qurango.net/radio/mustafa_raad_alazawy",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 83,
      "name": " إذاعة مفتاح السلطني",
      "url": "https://backup.qurango.net/radio/muftah_alsaltany_aldori_an_abi_amr ",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 84,
      "name": " إذاعة ماهر شخاشيرو",
      "url": "https://backup.qurango.net/radio/maher_shakhashero",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 85,
      "name": " إذاعة محمود الشيمي",
      "url": "https://backup.qurango.net/radio/mahmood_alsheimy",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 86,
      "name": " إذاعة خالد المهنا",
      "url": "https://backup.qurango.net/radio/khalid_almohana",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 87,
      "name": " إذاعة عادل الكلباني",
      "url": "https://backup.qurango.net/radio/adel_alkhalbany",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 88,
      "name": " إذاعة موسى بلال",
      "url": "https://backup.qurango.net/radio/mousa_bilal",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 89,
      "name": " إذاعة حاتم فريد الواعر",
      "url": "https://backup.qurango.net/radio/hatem_fareed_alwaer",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 9,
      "name": "إذاعة الزين محمد أحمد",
      "url": "https://backup.qurango.net/radio/alzain_mohammad_ahmad",
      "recent_date": "2020-04-25 16:04:04"
    },
    {
      "id": 90,
      "name": " إذاعة محمود الرفاعي",
      "url": "https://backup.qurango.net/radio/mahmood_al_rifai",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 91,
      "name": " إذاعة ابراهيم الدوسري",
      "url": "https://backup.qurango.net/radio/ibrahim_aldosari",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 92,
      "name": " إذاعة مفتاح السلطني",
      "url": "https://backup.qurango.net/radio/muftah_alsaltany_aldorai",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 93,
      "name": " إذاعة جمعان العصيمي",
      "url": "https://backup.qurango.net/radio/jamaan_alosaimi",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 94,
      "name": " إذاعة مفتاح السلطني",
      "url": "https://backup.qurango.net/radio/muftah_alsaltany",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 95,
      "name": " إذاعة يوسف بن نوح أحمد",
      "url": "https://backup.qurango.net/radio/yousef_bin_noah_ahmad",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 96,
      "name": " إذاعة مفتاح السلطني",
      "url": "https://backup.qurango.net/radio/muftah_alsaltany_ibn_thakwan_an_ibn_amr",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 97,
      "name": " إذاعة معيض الحارثي",
      "url": "https://backup.qurango.net/radio/moeedh_alharthi",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 98,
      "name": " إذاعة محمد رشاد الشريف",
      "url": "https://backup.qurango.net/radio/mohammad_rashad_alshareef",
      "recent_date": "2020-04-25 16:04:05"
    },
    {
      "id": 99,
      "name": " إذاعة أحمد خضر الطرابلسي",
      "url": "https://backup.qurango.net/radio/ahmad_khader_altarabulsi",
      "recent_date": "2020-04-25 16:04:05"
    }
  ];
}