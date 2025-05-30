class QuranSurahPlayer {
static const Map<String, List> reciters = {
    "reciters": [
      {
        "id": 1,
        "name": "abdallah_abdal",
        "name_arabic": "عبد الله العبد",
        "nationality": "غير معروف"
      },
      {
        "id": 2,
        "name": "abdul_muhsin_alqasim",
        "name_arabic": "عبد المحسن القاسم",
        "nationality": "السعودية"
      },
      {
        "id": 3,
        "name": "abdulbaset_mujawwad",
        "name_arabic": "عبد الباسط مجود",
        "nationality": "مصر"
      },
      {
        "id": 4,
        "name": "abdulbaset_warsh",
        "name_arabic": "عبد الباسط ورش",
        "nationality": "مصر"
      },
      {
        "id": 5,
        "name": "abdulbaset_with_naeem_sultan_pickthall",
        "name_arabic": "عبد الباسط مع نعيم سلطان بيكتال",
        "nationality": "مصر"
      },
      {
        "id": 6,
        "name": "abdulbasit_w_ibrahim_walk_si",
        "name_arabic": "عبد الباسط مع إبراهيم ووك س إي",
        "nationality": "مصر"
      },
      {
        "id": 7,
        "name": "abdulkareem_al_hazmi",
        "name_arabic": "عبد الكريم الهذمي",
        "nationality": "السعودية"
      },
      {
        "id": 8,
        "name": "abdullaah_3awwaad_al-juhaynee",
        "name_arabic": "عبد الله عواد الجهني",
        "nationality": "السعودية"
      },
      {
        "id": 9,
        "name": "abdullaah_alee_jaabir",
        "name_arabic": "عبد الله علي جابر",
        "nationality": "السعودية"
      },
      {
        "id": 10,
        "name": "abdullaah_alee_jaabir_studio",
        "name_arabic": "عبد الله علي جابر استوديو",
        "nationality": "السعودية"
      },
      {
        "id": 11,
        "name": "abdullaah_basfar",
        "name_arabic": "عبد الله بسفر",
        "nationality": "السعودية"
      },
      {
        "id": 12,
        "name": "abdullah_basfar_w_ibrahim_walk_si",
        "name_arabic": "عبد الله بسفر مع إبراهيم ووك س إي",
        "nationality": "غير معروف"
      },
      {
        "id": 13,
        "name": "abdullah_matroud",
        "name_arabic": "عبد الله مترود",
        "nationality": "السعودية"
      },
      {
        "id": 14,
        "name": "abdurrashid_sufi_-_khalaf_3an_7amza_recitation",
        "name_arabic": "عبد الرشيد صوفي - خلف عن حمزة",
        "nationality": "غير معروف"
      },
      {
        "id": 15,
        "name": "abdurrashid_sufi_abi_al7arith",
        "name_arabic": "عبد الرشيد صوفي أبي الحارث",
        "nationality": "غير معروف"
      },
      {
        "id": 16,
        "name": "abdurrashid_sufi_doori",
        "name_arabic": "عبد الرشيد صوفي دوري",
        "nationality": "غير معروف"
      },
      {
        "id": 17,
        "name": "abdurrashid_sufi_shu3ba",
        "name_arabic": "عبد الرشيد صوفي شعبة",
        "nationality": "غير معروف"
      },
      {
        "id": 18,
        "name": "abdurrashid_sufi_soosi_2020",
        "name_arabic": "عبد الرشيد صوفي سوسي 2020",
        "nationality": "غير معروف"
      },
      {
        "id": 19,
        "name": "abdurrashid_sufi_soosi_rec",
        "name_arabic": "عبد الرشيد صوفي سوسي تلاوة",
        "nationality": "غير معروف"
      },
      {
        "id": 20,
        "name": "abu_bakr_ash-shatri_tarawee7",
        "name_arabic": "أبو بكر الشاطري التراويح",
        "nationality": "السعودية"
      },
      {
        "id": 21,
        "name": "adel_kalbani",
        "name_arabic": "عادل الكلباني",
        "nationality": "السعودية"
      },
      {
        "id": 22,
        "name": "adel_kalbani_1437",
        "name_arabic": "عادل الكلباني 1437",
        "nationality": "السعودية"
      },
      {
        "id": 23,
        "name": "ahmad_alhuthayfi",
        "name_arabic": "أحمد الحذيفي",
        "nationality": "السعودية"
      },
      {
        "id": 24,
        "name": "ahmad_nauina",
        "name_arabic": "أحمد نعينة",
        "nationality": "غير معروف"
      },
      {
        "id": 25,
        "name": "ahmed_ibn_3ali_al-3ajamy",
        "name_arabic": "أحمد بن علي العجمي",
        "nationality": "السعودية"
      },
      {
        "id": 26,
        "name": "akram_al_alaqmi",
        "name_arabic": "أكرم العاقمي",
        "nationality": "غير معروف"
      },
      {
        "id": 27,
        "name": "alhusaynee_al3azazee_with_children",
        "name_arabic": "الحسيني العزازي مع الأطفال",
        "nationality": "غير معروف"
      },
      {
        "id": 28,
        "name": "ali_hajjaj_alsouasi",
        "name_arabic": "علي حجاج السويسي",
        "nationality": "مصر"
      },
      {
        "id": 29,
        "name": "aziz_alili",
        "name_arabic": "عزيز عليلي",
        "nationality": "غير معروف"
      },
      {
        "id": 30,
        "name": "bandar_baleela",
        "name_arabic": "بندر بليلة",
        "nationality": "السعودية"
      },
      {
        "id": 31,
        "name": "fares", 
        "name_arabic": "فارس", 
        "nationality": "غير معروف"
      },
      {
        "id": 32,
        "name": "fatih_seferagic",
        "name_arabic": "فتحي سفراغيش",
        "nationality": "البوسنة"
      },
      {
        "id": 33,
        "name": "husary_muallim",
        "name_arabic": "الحصري معلم",
        "nationality": "مصر"
      },
      {
        "id": 34,
        "name": "husary_muallim_kids_repeat",
        "name_arabic": "الحصري معلم للأطفال تكرار",
        "nationality": "مصر"
      },
      {
        "id": 35,
        "name": "huthayfi", 
        "name_arabic": "حذيفي", 
        "nationality": "السعودية"
      },
      {
        "id": 36,
        "name": "huthayfi_qaloon",
        "name_arabic": "حذيفي قلون",
        "nationality": "السعودية"
      },
      {
        "id": 37,
        "name": "ibrahim_al_akhdar",
        "name_arabic": "إبراهيم الأخضر",
        "nationality": "السعودية"
      },
      {
        "id": 38,
        "name": "imad_zuhair_hafez",
        "name_arabic": "عماد زهير حافظ",
        "nationality": "غير معروف"
      },
      {
        "id": 39,
        "name": "jibreen", 
        "name_arabic": "جبريل", 
        "nationality": "السعودية"
      },
      {
        "id": 40,
        "name": "khalifah_taniji",
        "name_arabic": "خليفة تانجي",
        "nationality": "غير معروف"
      },
      {
        "id": 41,
        "name": "khayat", 
        "name_arabic": "خيّاط", 
        "nationality": "غير معروف"
      },
      {
        "id": 42,
        "name": "madinah_1419",
        "name_arabic": "المدينة 1419",
        "nationality": "السعودية"
      },
      {
        "id": 43,
        "name": "madinah_1423",
        "name_arabic": "المدينة 1423",
        "nationality": "السعودية"
      },
      {
        "id": 44,
        "name": "madinah_1426",
        "name_arabic": "المدينة 1426",
        "nationality": "السعودية"
      },
      {
        "id": 45,
        "name": "madinah_1427",
        "name_arabic": "المدينة 1427",
        "nationality": "السعودية"
      },
      {
        "id": 46,
        "name": "madinah_1429",
        "name_arabic": "المدينة 1429",
        "nationality": "السعودية"
      },
      {
        "id": 47,
        "name": "madinah_1430",
        "name_arabic": "المدينة 1430",
        "nationality": "السعودية"
      },
      {
        "id": 48,
        "name": "madinah_1431",
        "name_arabic": "المدينة 1431",
        "nationality": "السعودية"
      },
      {
        "id": 49,
        "name": "madinah_1432",
        "name_arabic": "المدينة 1432",
        "nationality": "السعودية"
      },
      {
        "id": 50,
        "name": "madinah_1433",
        "name_arabic": "المدينة 1433",
        "nationality": "السعودية"
      },
      {
        "id": 51,
        "name": "madinah_1435",
        "name_arabic": "المدينة 1435",
        "nationality": "السعودية"
      },
      {
        "id": 52,
        "name": "madinah_1436",
        "name_arabic": "المدينة 1436",
        "nationality": "السعودية"
      },
      {
        "id": 53,
        "name": "madinah_1437",
        "name_arabic": "المدينة 1437",
        "nationality": "السعودية"
      },
      {
        "id": 54,
        "name": "madinah_1439",
        "name_arabic": "المدينة 1439",
        "nationality": "السعودية"
      },
      {
        "id": 55,
        "name": "madinah_1440",
        "name_arabic": "المدينة 1440",
        "nationality": "السعودية"
      },
      {
        "id": 56,
        "name": "madinah_1441",
        "name_arabic": "المدينة 1441",
        "nationality": "السعودية"
      },
      {
        "id": 57,
        "name": "madinah_1442",
        "name_arabic": "المدينة 1442",
        "nationality": "السعودية"
      },
      {
        "id": 58,
        "name": "maher_256",
        "name_arabic": "ماهر 256",
        "nationality": "السعودية"
      },
      {
        "id": 59,
        "name": "mahmood_ali_albana",
        "name_arabic": "محمود علي البنا",
        "nationality": "مصر"
      },
      {
        "id": 60,
        "name": "mahmood_khaleel_al-husaree",
        "name_arabic": "محمود خليل الحصري",
        "nationality": "مصر"
      },
      {
        "id": 61,
        "name": "mahmood_khaleel_al-husaree_doori",
        "name_arabic": "محمود خليل الحصري دوري",
        "nationality": "مصر"
      },
      {
        "id": 62,
        "name": "mahmood_khaleel_al-husaree_iza3a",
        "name_arabic": "محمود خليل الحصري الإذاعة",
        "nationality": "مصر"
      },
      {
        "id": 63,
        "name": "makkah_1425",
        "name_arabic": "مكة 1425",
        "nationality": "السعودية"
      },
      {
        "id": 64,
        "name": "makkah_1426",
        "name_arabic": "مكة 1426",
        "nationality": "السعودية"
      },
      {
        "id": 65,
        "name": "makkah_1427",
        "name_arabic": "مكة 1427",
        "nationality": "السعودية"
      },
      {
        "id": 66,
        "name": "makkah_1428",
        "name_arabic": "مكة 1428",
        "nationality": "السعودية"
      },
      {
        "id": 67,
        "name": "makkah_1429",
        "name_arabic": "مكة 1429",
        "nationality": "السعودية"
      },
      {
        "id": 68,
        "name": "makkah_1431",
        "name_arabic": "مكة 1431",
        "nationality": "السعودية"
      },
      {
        "id": 69,
        "name": "makkah_1432",
        "name_arabic": "مكة 1432",
        "nationality": "السعودية"
      },
      {
        "id": 70,
        "name": "makkah_1433",
        "name_arabic": "مكة 1433",
        "nationality": "السعودية"
      },
      {
        "id": 71,
        "name": "makkah_1434",
        "name_arabic": "مكة 1434",
        "nationality": "السعودية"
      },
      {
        "id": 72,
        "name": "makkah_1435",
        "name_arabic": "مكة 1435",
        "nationality": "السعودية"
      },
      {
        "id": 73,
        "name": "makkah_1436",
        "name_arabic": "مكة 1436",
        "nationality": "السعودية"
      },
      {
        "id": 74,
        "name": "makkah_1438",
        "name_arabic": "مكة 1438",
        "nationality": "السعودية"
      },
      {
        "id": 75,
        "name": "makkah_1439",
        "name_arabic": "مكة 1439",
        "nationality": "السعودية"
      },
      {
        "id": 76,
        "name": "makkah_1441",
        "name_arabic": "مكة 1441",
        "nationality": "السعودية"
      },
      {
        "id": 77,
        "name": "masjid_quba_1434",
        "name_arabic": "مسجد قباء 1434",
        "nationality": "السعودية"
      },
      {
        "id": 78,
        "name": "mehysni", 
        "name_arabic": "محيسني", 
        "nationality": "السعودية"
      },
      {
        "id": 79,
        "name": "mishaari_raashid_al_3afaasee",
        "name_arabic": "مشاري راشد العفاسي",
        "nationality": "الكويت"
      },
      {
        "id": 80,
        "name": "mishaari_w_ibrahim_walk_si",
        "name_arabic": "مشاري مع إبراهيم ووك س إي",
        "nationality": "غير معروف"
      },
      {
        "id": 81,
        "name": "mishaari_with_saabir_mkhan",
        "name_arabic": "مشاري مع صابر خان",
        "nationality": "غير معروف"
      },
      {
        "id": 82,
        "name": "mohammad_ismaeel_almuqaddim",
        "name_arabic": "محمد إسماعيل المقدّم",
        "nationality": "السعودية"
      },
      {
        "id": 83,
        "name": "mostafa_ismaeel",
        "name_arabic": "مصطفى إسماعيل",
        "nationality": "مصر"
      },
      {
        "id": 84,
        "name": "mu7ammad_7assan",
        "name_arabic": "محمد حسن",
        "nationality": "غير معروف"
      },
      {
        "id": 85,
        "name": "muhaisny_1435",
        "name_arabic": "محيسني 1435",
        "nationality": "السعودية"
      },
      {
        "id": 86,
        "name": "muhammad_abdulkareem",
        "name_arabic": "محمد عبد الكريم",
        "nationality": "غير معروف"
      },
      {
        "id": 87,
        "name": "muhammad_alhaidan",
        "name_arabic": "محمد الحيدان",
        "nationality": "السعودية"
      },
      {
        "id": 88,
        "name": "muhammad_ayub_and_mikaal_waters",
        "name_arabic": "محمد أيوب وميكال ووترز",
        "nationality": "غير معروف"
      },
      {
        "id": 89,
        "name": "muhammad_ayyoob",
        "name_arabic": "محمد أيوب",
        "nationality": "السعودية"
      },
      {
        "id": 90,
        "name": "muhammad_ayyoob_hq",
        "name_arabic": "محمد أيوب",
        "nationality": "السعودية"
      },
      {
        "id": 91,
        "name": "muhammad_khaleel",
        "name_arabic": "محمد خليل",
        "nationality": "غير معروف"
      },
      {
        "id": 92,
        "name": "muhammad_patel",
        "name_arabic": "محمد باتل",
        "nationality": "غير معروف"
      },
      {
        "id": 93,
        "name": "muhammad_siddeeq_al-minshaawee",
        "name_arabic": "محمد صديق المنشاوي",
        "nationality": "مصر"
      },
      {
        "id": 94,
        "name": "minshawi_mujawwad",
        "name_arabic": "محمد صديق المنشاوي مجود",
        "nationality": "مصر"
      },
      {
        "id": 95,
        "name": "mustafa_al3azzawi",
        "name_arabic": "مصطفى العزازي",
        "nationality": "غير معروف"
      },
      {
        "id": 96,
        "name": "nabil_rifa3i",
        "name_arabic": "نبيل رفاعي",
        "nationality": "مصر"
      },
      {
        "id": 97,
        "name": "noreen_siddiq",
        "name_arabic": "نورين صديق",
        "nationality": "غير معروف"
      },
      {
        "id": 98,
        "name": "rifai", 
        "name_arabic": "رفاعي", 
        "nationality": "مصر"
      },
      {
        "id": 99,
        "name": "sa3ood_al-shuraym",
        "name_arabic": "سعود الشريم",
        "nationality": "السعودية"
      },
      {
        "id": 100,
        "name": "sadaqat_ali",
        "name_arabic": "صادق علي",
        "nationality": "غير معروف"
      },
      {
        "id": 101,
        "name": "sahl_yaaseen",
        "name_arabic": "سهل ياسين",
        "nationality": "غير معروف"
      },
      {
        "id": 102,
        "name": "salah_alhashim",
        "name_arabic": "صالح الهاشمي",
        "nationality": "غير معروف"
      },
      {
        "id": 103,
        "name": "salahbudair",
        "name_arabic": "صالح البدير",
        "nationality": "السعودية"
      },
      {
        "id": 104,
        "name": "saleh_al_taleb",
        "name_arabic": "صالح الطلّاب",
        "nationality": "السعودية"
      },
      {
        "id": 105,
        "name": "shakir_qasami_with_english",
        "name_arabic": "شاكير قاسمي مع الإنجليزية",
        "nationality": "غير معروف"
      },
      {
        "id": 106,
        "name": "sudais_and_shuraim_with_urdu",
        "name_arabic": "السديس والشريم مع الأردو",
        "nationality": "السعودية"
      },
      {
        "id": 107,
        "name": "sudais_shuraim_and_english",
        "name_arabic": "السديس والشريم مع الإنجليزية",
        "nationality": "السعودية"
      },
      {
        "id": 108,
        "name": "sudais_shuraim_with_naeem_sultan_pickthall",
        "name_arabic": "السديس والشريم مع نعيم سلطان بيكتال",
        "nationality": "السعودية"
      },
      {
        "id": 109,
        "name": "tawfeeq_bin_saeed-as-sawaaigh",
        "name_arabic": "توفيق بن سعيد السواياغ",
        "nationality": "غير معروف"
      },
      {
        "id": 110,
        "name": "thubaity", 
        "name_arabic": "الثبيتي", 
        "nationality": "السعودية"
      },
      {
        "id": 111,
        "name": "wadee_hammadi_al-yamani",
        "name_arabic": "وادي حمادي اليماني",
        "nationality": "اليمن"
      },
      {
        "id": 112,
        "name": "yasser_ad-dussary",
        "name_arabic": "ياسر الدوسري",
        "nationality": "السعودية"
      }
    ],
  };}




