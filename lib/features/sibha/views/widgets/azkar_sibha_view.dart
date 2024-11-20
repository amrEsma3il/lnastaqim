import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/sibha/views/screens/sibha_view.dart';

class AzkarSibhaView extends StatelessWidget {
  const AzkarSibhaView({super.key});

  static const Map<String, dynamic> azkar = {
    "سبحان الله":
        "قال رسول الله ﷺ : (أَيَعْجِزُ أحدُكم ، أن يكسِبَ كُلَّ يومٍ ألفَ حسَنَةٍ ؟ يُسَبِّحُ اللهَ مائَةَ تسبيحَةٍ ؛ فَيَكْتُبُ اللهُ لَهُ بَها ألفَ حسَنَةٍ ، ويَحُطُّ عنه بِها ألْفَ خَطِيئَةٍ ) . رواه مسلم",
    "الحمد لله":
        "قال رسول الله ﷺ : (الطُّهورُ شطْرُ الإيمانِ ، والحمدُ للهِ تملأُ الميزانَ ، وسُبحانَ اللهِ والحمدُ للهِ تَملآنِ ما بين السماءِ والأرضِ ) . رواه مسلم",
    "لا إله إلا الله ":
        "قال رسول الله ﷺ : (فإنَّ اللَّهَ قدْ حَرَّمَ علَى النَّارِ مَن قالَ: لا إلَهَ إلَّا اللَّهُ، يَبْتَغِي بذلكَ وجْهَ اللَّهِ ) . رواه البخاري",
    "الله أكبر":
        "قال الله تعالى : ( َقُلِ الْحَمْدُ لِلَّهِ الَّذِي لَمْ يَتَّخِذْ وَلَدًا وَلَمْ يَكُن لَّهُ شَرِيكٌ فِي الْمُلْكِ وَلَمْ يَكُن لَّهُ وَلِيٌّ مِّنَ الذُّلِّ  وَكَبِّرْهُ تَكْبِيرًا) . سورة : الْإِسْرَآء - الأية :(111)",
    "سبحان الله، والحمد لله، ولا إله إلا الله، والله أكبر":
        "قال رسول الله ﷺ : ( أحبُّ الكَلامِ إلى اللهِ أرْبَعٌ: سُبْحانَ اللهِ، والْحَمْدُ لِلَّهِ، ولا إلَهَ إلَّا اللَّهُ، واللَّهُ أكْبَرُ) . رواه مسلم",
    "سبحان الله وبحمده":
        "قال رسول الله ﷺ : ( من قال : سبحان اللهِ وبحمدِه مائةَ مرةٍ غُفرَتْ له ذنوبُه وإنْ كانتْ مثلَ زبَدِ البحرِ) . رواه الترمذي ",
    "أستغفر الله":
        "قال الله عز وجل : ( فَقُلْتُ اسْتَغْفِرُوا رَبَّكُمْ إِنَّهُ كَانَ غَفَّارًا (10) يُرْسِلِ السَّمَاءَ عَلَيْكُم مِّدْرَارًا (11) وَيُمْدِدْكُم بِأَمْوَالٍ وَبَنِينَ وَيَجْعَل لَّكُمْ جَنَّاتٍ وَيَجْعَل لَّكُمْ أَنْهَارًا (12))  سوره نوح : 10 - 12",
    "حسبي الله ونعم الوكيل":
        "قال الله تعالى : (الَّذِينَ قَالَ لَهُمُ النَّاسُ إِنَّ النَّاسَ قَدْ جَمَعُوا لَكُمْ فَاخْشَوْهُمْ فَزَادَهُمْ إِيمَانًا وَقَالُوا حَسْبُنَا اللَّـهُ وَنِعْمَ الْوَكِيلُ) سوره أل عمران : 173",
    "لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ":
        "قال رسول الله ﷺ: (دعوةُ ذي النُّونِ؛ إذ دعا بها في بَطنِ الحوتِ: لا إلهَ إلَّا أنتَ سُبْحانَكَ، إنِّي كنتُ مِن الظالمينَ، فإنَّه لن يَدعُوَ بها مسلمٌ في شيءٍ إلَّا استجابَ له) . رواه الترمذي ",
    "اللهم صل على سيدنا محمد":
        "عن ابي هريره ان رسول الله ﷺ قال : (مَن صلى عَلَيَّ واحدةً ، صلى اللهُ عليه بها عَشْرًا) . رواه مسلم",
    "سبحان الله وبحمده،سبحان الله العظيم":
        "قال رسول الله ﷺ: (كَلِمَتَانِ خَفِيفَتَانِ علَى اللِّسَانِ، ثَقِيلَتَانِ في المِيزَانِ، حَبِيبَتَانِ إلى الرَّحْمَنِ: سُبْحَانَ اللهِ وَبِحَمْدِهِ، سُبْحَانَ اللهِ العَظِيمِ.) . رواه البخاري",
    "لا إلَهَ إلَّا اللَّهُ وحدَهُ لا شريكَ لَهُ ، لَهُ الملكُ ولَهُ الحمدُ وَهوَ على كلِّ شيءٍ قديرٌ":
        " في حديث ابي هريرة يقول رسول الله ﷺ: ( مَن قالَ: لا إلَهَ إلَّا اللَّهُ، وحْدَهُ لا شَرِيكَ له، له المُلْكُ وله الحَمْدُ، وهو علَى كُلِّ شَيءٍ قَدِيرٌ، في يَومٍ مِئَةَ مَرَّةٍ؛ كانَتْ له عَدْلَ عَشْرِ رِقابٍ، وكُتِبَتْ له مِئَةُ حَسَنَةٍ، ومُحِيَتْ عنْه مِئَةُ سَيِّئَةٍ، وكانَتْ له حِرْزًا مِنَ الشَّيْطانِ يَومَهُ ذلكَ حتَّى يُمْسِيَ، ولَمْ يَأْتِ أحَدٌ بأَفْضَلَ ممَّا جاءَ به، إلَّا أحَدٌ عَمِلَ أكْثَرَ مِن ذلكَ.) .  رواه البخاري",
    "لاحول ولا قوة إلا بالله":
        "قال رسول الله ﷺ : ( ألَا أدُلُّكَ علَى كَلِمَةٍ هي كَنْزٌ مِن كُنُوزِ الجَنَّةِ؟ لا حَوْلَ ولَا قُوَّةَ إلَّا باللَّهِ) . متفق عليه"
  };

  @override
  Widget build(BuildContext context) {
    final TextController textController = Get.find();

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
            return GestureDetector(
              onTap: () {
                textController.updateText(azkar.keys.elementAt(index), index);
                Get.back();
              },
              child: TasbeehZekr(
                zekr: azkar.keys.elementAt(index),
                zekrImportance: azkar.values.elementAt(index),
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }
}

class TasbeehZekr extends StatelessWidget {
  const TasbeehZekr(
      {super.key,
      required this.index,
      required this.zekr,
      required this.zekrImportance});

  final int index;
  final String zekr;
  final String zekrImportance;

  @override
  Widget build(BuildContext context) {
    final TextController textController = Get.find();
    bool isSelected = textController.selectedIndex == index;

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
        const SizedBox(height: 20),
        Text(
          zekrImportance,
          style: const TextStyle(
            fontFamily: "naskh",
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 50),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: SizedBox(child: Divider()),
        ),
      ],
    );
  }
}
