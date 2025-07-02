import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/sibha/views/screens/sibha_view.dart';

class AzkarSibhaView extends StatelessWidget {
  const AzkarSibhaView({super.key});
static const Map<String, Map<String, dynamic>> azkar = {
  "سبحان الله": {
    "repeats": 1,
    "repeatPerRound": 33,
    "importance":
        "قال رسول الله ﷺ : (أَيَعْجِزُ أحدُكم ، أن يكسِبَ كُلَّ يومٍ ألفَ حسَنَةٍ ؟ يُسَبِّحُ اللهَ مائَةَ تسبيحَةٍ ؛ فَيَكْتُبُ اللهُ لَهُ بَها ألفَ حسَنَةٍ ، ويَحُطُّ عنه بِها ألْفَ خَطِيئَةٍ ) . رواه مسلم",
  },
  "الحمد لله": {
    "repeats": 1,
    "repeatPerRound": 33,
    "importance":
        "قال رسول الله ﷺ : (الطُّهورُ شطْرُ الإيمانِ ، والحمدُ للهِ تملأُ الميزانَ ، وسُبحانَ اللهِ والحمدُ للهِ تَملآنِ ما بين السماءِ والأرضِ ) . رواه مسلم",
  },
  "لا إله إلا الله": {
    "repeats": 1,
    "repeatPerRound": 33,
    "importance":
        "قال رسول الله ﷺ : (فإنَّ اللَّهَ قدْ حَرَّمَ علَى النَّارِ مَن قالَ: لا إلَهَ إلَّا اللَّهُ، يَبْتَغِي بذلكَ وجْهَ اللَّهِ ) . رواه البخاري",
  },
  "الله أكبر": {
    "repeats": 1,
    "repeatPerRound": 33,
    "importance":
        "قال الله تعالى : (وَكَبِّرْهُ تَكْبِيرًا) . سورة الإسراء: 111",
  },
  "سبحان الله، والحمد لله، ولا إله إلا الله، والله أكبر": {
    "repeats": 1,
    "repeatPerRound": 25,
    "importance":
        "قال رسول الله ﷺ : ( أحبُّ الكَلامِ إلى اللهِ أرْبَعٌ: سُبْحانَ اللهِ، والْحَمْدُ لِلَّهِ، ولا إلَهَ إلَّا اللَّهُ، واللَّهُ أكْبَرُ) . رواه مسلم",
  },
  "سبحان الله وبحمده": {
    "repeats": 1,
    "repeatPerRound": 100,
    "importance":
        "قال رسول الله ﷺ : ( من قال : سبحان اللهِ وبحمدِه مائةَ مرةٍ غُفرَتْ له ذنوبُه وإنْ كانتْ مثلَ زبَدِ البحرِ) . رواه الترمذي ",
  },
  "أستغفر الله": {
    "repeats": 3,
    "repeatPerRound": 33,
    "importance":
        "قال الله عز وجل : (فَقُلْتُ اسْتَغْفِرُوا رَبَّكُمْ إِنَّهُ كَانَ غَفَّارًا) . نوح: 10",
  },
  "حسبي الله ونعم الوكيل": {
    "repeats": 1,
    "repeatPerRound": 10,
    "importance":
        "قال الله تعالى : (الَّذِينَ قَالَ لَهُمُ النَّاسُ ... وَقَالُوا حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ) . آل عمران: 173",
  },
  "لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ": {
    "repeats": 1,
    "repeatPerRound": 7,
    "importance":
        "قال رسول الله ﷺ: (دعوةُ ذي النُّونِ ... فإنَّه لن يَدعُوَ بها مسلمٌ إلَّا استجابَ له) . رواه الترمذي ",
  },
  "اللهم صل على سيدنا محمد": {
    "repeats": 1,
    "repeatPerRound": 10,
    "importance":
        "عن أبي هريرة أن رسول الله ﷺ قال : (مَن صلى عَلَيَّ واحدةً ، صلى اللهُ عليه بها عَشْرًا) . رواه مسلم",
  },
  "سبحان الله وبحمده،سبحان الله العظيم": {
    "repeats": 1,
    "repeatPerRound": 33,
    "importance":
        "قال رسول الله ﷺ: (كَلِمَتَانِ خَفِيفَتَانِ ... حَبِيبَتَانِ إلى الرَّحْمَنِ: سُبْحانَ اللهِ وَبِحَمْدِهِ، سُبْحانَ اللهِ العَظِيمِ.) . رواه البخاري",
  },
  "لا إلَهَ إلَّا اللَّهُ وحدَهُ لا شريكَ لَهُ": {
    "repeats": 1,
    "repeatPerRound": 100,
    "importance":
        "قال ﷺ: (مَن قالَ: لا إلَهَ إلَّا اللَّهُ ... في يَومٍ مِئَةَ مَرَّةٍ ... كانَتْ له عَدْلَ عَشْرِ رِقابٍ) . رواه البخاري",
  },
  "لاحول ولا قوة إلا بالله": {
    "repeats": 1,
    "repeatPerRound": 10,
    "importance":
        "قال رسول الله ﷺ : (ألَا أدُلُّكَ علَى كَلِمَةٍ هي كَنْزٌ مِن كُنُوزِ الجَنَّةِ؟ لا حَوْلَ ولَا قُوَّةَ إلَّا باللَّهِ) . متفق عليه"
  },
  "رضيت بالله رباً، وبالإسلام ديناً، وبمحمد ﷺ نبيًا": {
    "repeats": 1,
    "repeatPerRound": 3,
    "importance":
        "قال رسول الله ﷺ: (مَن قالَ حينَ يُصبِحُ ... كانَ حقًّا على اللَّهِ أن يُرضِيَهُ). رواه أحمد"
  },
  "اللهم اغفر لي ولوالديّ": {
    "repeats": 1,
    "repeatPerRound": 10,
    "importance":
        "قال تعالى: (رَّبَّنَا اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُؤْمِنِينَ) . إبراهيم: 41"
  },
  "اللهم إني أسألك الجنة وأعوذ بك من النار": {
    "repeats": 1,
    "repeatPerRound": 7,
    "importance":
        "قال رسول الله ﷺ: (مَن سألَ اللَّهَ الجنَّةَ ثلاثَ مرَّاتٍ ... قالتِ الجنَّةُ: اللَّهمَّ أدخِلهُ الجنةَ). رواه الترمذي"
  },
  "اللهم آتنا في الدنيا حسنة وفي الآخرة حسنة": {
    "repeats": 1,
    "repeatPerRound": 5,
    "importance":
        "قال تعالى: (رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً ...) . البقرة: 201"
  },
  "اللهم إنك عفو تحب العفو فاعف عني": {
    "repeats": 1,
    "repeatPerRound": 10,
    "importance":
        "قالت عائشة رضي الله عنها: قلت: يا رسول الله ... قال: (قولي: اللهم إنك عفو تحب العفو فاعف عني). رواه الترمذي"
  },
  "اللهم ثبت قلبي على دينك": {
    "repeats": 1,
    "repeatPerRound": 7,
    "importance":
        "كان من دعاء النبي ﷺ: (يا مقلب القلوب ثبت قلبي على دينك). رواه الترمذي"
  },
  "يا حي يا قيوم برحمتك أستغيث": {
    "repeats": 1,
    "repeatPerRound": 5,
    "importance":
        "من دعاء النبي ﷺ في الكرب والضيق"
  }
};
  @override
  Widget build(BuildContext context) {
    final ZekrController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: const Text(
          "اختر الذكر",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: ListView.builder(
          itemCount: azkar.length,
          itemBuilder: (BuildContext context, int index) {
            final zekrKey = azkar.keys.elementAt(index);
            final zekrData = azkar[zekrKey]!;
            return GestureDetector(
              onTap: () {
                final zekrModel = ZekrModel(
                  text: zekrKey,
                  category: "أذكار التسبيح",
                  repeatPerRound: zekrData["repeatPerRound"],
                  totalRounds: zekrData["repeats"],
                  note: zekrData["importance"],
                );
                controller.updateZekr(zekrModel);
                Get.back();
              },
              child: TasbeehZekr(
                zekr: zekrKey,
                zekrImportance: zekrData["importance"],
                index: index,
                isSelected: controller.selectedZekr.value.text == zekrKey,
              ),
            );
          },
        ),
      ),
    );
  }
}

class TasbeehZekr extends StatelessWidget {
  const TasbeehZekr({
    super.key,
    required this.index,
    required this.zekr,
    required this.zekrImportance,
    required this.isSelected,
  });

  final int index;
  final String zekr;
  final String zekrImportance;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final ZekrController controller = Get.find();

    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(
                    color: AppColor.primary,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: ShapeDecoration(
                    color: isSelected ? AppColor.primary : Colors.transparent,
                    shape: const CircleBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                zekr,
                style: TextStyle(
                  fontFamily: "naskh",
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          zekrImportance,
          style: const TextStyle(
            fontFamily: "naskh",
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: SizedBox(child: Divider()),
        ),
      ],
    );
  }
}