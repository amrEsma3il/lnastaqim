// إعادة تصميم شاشة المسبحة مع إحصائيات كاملة وتفاصيل متقدمة، إضافة الإنجازات، مشاركة الإنجاز، الإهتزاز
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lnastaqim/config/routing/app_routes_info/app_routes_name.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/utilits/functions/toast_message.dart';
import '../widgets/custom_sibha_appbar.dart';

class ZekrModel {
  final String text;
  final String category;
  final int repeatPerRound;
  final int totalRounds;
  final String? note;

  ZekrModel({
    required this.text,
    required this.category,
    this.repeatPerRound = 33,
    this.totalRounds = 1,
    this.note,
  });
}

//-----------------------------------------------------------------------------
// كونترولر GetX
//-----------------------------------------------------------------------------
class ZekrController extends GetxController {
  static ZekrController instance = Get.put(ZekrController());

  /// الذِّكر الحالي
  var selectedZekr =
      ZekrModel(text: "سبحان الله", category: "أذكار التسبيح").obs;

  /// عدّاد التسبيحات في الجولة الجارية
  var currentCount = 0.obs;

  /// عدد الجولات المُكتَمَلة (يبدأ 0)
  var currentRound = 0.obs;

  /// مجموع ما سُبِّح في الجلسة
  var totalCounter = 0.obs;

  /// هل اكتملت كل الجولات لهذا الذِّكر؟
  var achievementUnlocked = false.obs;

  /// هل الوضع الحر مفعل؟
  var isFreeMode = false.obs;

  //───────────────────────────────────────────────────────────────────────────
  // استبدال الذِّكر
  //───────────────────────────────────────────────────────────────────────────
  void updateZekr(ZekrModel newZekr) {
    selectedZekr.value = newZekr;
    resetAll();
  }

  //───────────────────────────────────────────────────────────────────────────
  // ضغطة على السبحة
  //───────────────────────────────────────────────────────────────────────────
  void incrementCounter() {
    if (achievementUnlocked.value) return;

    currentCount.value++;
    if (!isFreeMode.value) {
      totalCounter.value++;
      HapticFeedback.lightImpact();

      final totalRounds = selectedZekr.value.totalRounds;
      final repeatPerRound = selectedZekr.value.repeatPerRound;

      if (currentCount.value == repeatPerRound) {
        currentRound.value++;
        if (currentRound.value < totalRounds) {
          currentCount.value = 0;
        } else {
          _finishAllRounds();
        }
      }
    } else {
      totalCounter.value++;
    }
  }

  //───────────────────────────────────────────────────────────────────────────
  void _finishAllRounds() {
    if (!isFreeMode.value) {
      saveZekrToStats();
      achievementUnlocked.value = true;
      Get.snackbar(
        "🎉 مبروك!",
        "أنهيت كل تكرارات التسبيح!",
        backgroundColor: AppColor.lightBlue.withOpacity(0.6),
      );
    }
  }

  //───────────────────────────────────────────────────────────────────────────
  // إعادة تعيين الجلسة الحالية
  //───────────────────────────────────────────────────────────────────────────
  void resetAll() {
    currentCount.value = 0;
    currentRound.value = 0;
    totalCounter.value = 0;
    achievementUnlocked.value = false;
    isFreeMode.value = false; // إعادة تعيين الوضع الحر
  }

  //───────────────────────────────────────────────────────────────────────────
  // تبديل الوضع الحر
  //───────────────────────────────────────────────────────────────────────────
  void toggleFreeMode() {
    isFreeMode.value = !isFreeMode.value;
    currentCount.value = 0;
    totalCounter.value = 0;
    achievementUnlocked.value = false;
  }

  //───────────────────────────────────────────────────────────────────────────
  // مشاركة الإنجاز
  //───────────────────────────────────────────────────────────────────────────
  void shareAchievement() async {
    String text = "";
    if (!isFreeMode.value) {
      text =
          "لقد أتممت ${selectedZekr.value.text} عدد ${totalCounter.value} مرة في تطبيق لنستقيم 💠";
    } else {
      text = "لقد أتممت ${totalCounter.value} تسبيحة في تطبيق لنستقيم 💠";
    }

    await SharePlus.instance.share(ShareParams(text: text, subject: "تسابيح"));
  }

  //───────────────────────────────────────────────────────────────────────────
  // حفظ الإحصائيات في SharedPreferences
  //───────────────────────────────────────────────────────────────────────────
  Future<void> saveZekrToStats() async {
    if (!isFreeMode.value) {
      final prefs = await SharedPreferences.getInstance();
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final dayKey = 'stats_$today';
      final dayList = prefs.getStringList(dayKey) ?? [];
      final int roundTotal =
          selectedZekr.value.totalRounds * selectedZekr.value.repeatPerRound;
      dayList.add('${selectedZekr.value.text}|$roundTotal');
      await prefs.setStringList(dayKey, dayList.toSet().toList());
      final totalKey = 'total_${selectedZekr.value.text}';
      int total = prefs.getInt(totalKey) ?? 0;
      total += roundTotal;
      await prefs.setInt(totalKey, total);
      update();
    }
  }
} // واجهة السبحة الرئيسية
//-----------------------------------------------------------------------------
//

// افترض أن ZekrController و AppColor معرفين مسبقًا
class RotatingSibhaButton extends StatelessWidget {
  const RotatingSibhaButton({super.key, required this.controller});
  final ZekrController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final beadCount = controller.selectedZekr.value.repeatPerRound;
      final turns = (controller.currentCount.value % beadCount) / beadCount;

      return GestureDetector(
        onTap: controller.incrementCounter,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            AnimatedRotation(
              turns: turns,
              duration: const Duration(milliseconds: 250),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  _buildBeadRing(beadCount: 33, radius: 100),
                  _OrnateHead(
                    color: AppColor.primary,
                    radius: 100,
                    beadCount: beadCount,
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: AppColor.blueGreay,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${controller.totalCounter.value}',
                  style: TextStyle(fontSize: 50, color: AppColor.primary),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBeadRing({required int beadCount, required double radius}) {
    const beadSize = 14.0;
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        children: List.generate(beadCount, (i) {
          final angle = (i * 2 * math.pi) / beadCount;
          final x = (radius - beadSize) * math.cos(angle);
          final y = (radius - beadSize) * math.sin(angle);
          return Positioned(
            left: radius + x - beadSize / 2,
            top: radius + y - beadSize / 2,
            child: Container(
              width: beadSize,
              height: beadSize,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.primary.withOpacity(0.95),
                    AppColor.primary.withOpacity(0.65),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _OrnateHead extends StatelessWidget {
  const _OrnateHead({
    required this.color,
    required this.radius,
    required this.beadCount,
  });
  final Color color;
  final double radius;
  final int beadCount;

  @override
  Widget build(BuildContext context) {
    final darker = Color.lerp(color, Colors.black, .2)!;
    final lighter = Color.lerp(color, Colors.white, .3)!;

    // زاوية الميل لتكون مع الخرزة الأولى أو أي زاوية مرغوبة
    final startAngle = (2 * math.pi) / beadCount; // زاوية الخرزة الأولى
    final x = radius * math.cos(startAngle);
    final y = radius * math.sin(startAngle);

    return Positioned(
      left: radius + x + 4 / 2, // تعديل الموضع بناءً على الزاوية
      top: radius + y + 15 / 2,
      child: Transform.rotate(
        angle: startAngle + math.pi / 2, // تدوير الرأس ليكون مائلاً
        child: Column(
          children: [
            Container(
              width: 16,
              height: 34,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [lighter, darker],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: darker, width: 1.2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.star,
                  size: 10,
                  color: lighter.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: darker,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1.5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// صفحة السبحة الرئيسية
// -----------------------------------------------------------------------------
class SibhaView extends StatelessWidget {
  const SibhaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSibhaAppBar(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppImages.azkarBackground),
          ),
        ),
        child: Column(
          children: [
            // بطاقة الذكر
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 50, 35, 0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Obx(
                  () => Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          ZekrController.instance.isFreeMode.value
                              ? "تسبيح حر"
                              : ZekrController.instance.selectedZekr.value.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                            fontFamily: 'naskh',
                          ),
                        ),
                      ),
                      if (ZekrController.instance.selectedZekr.value.note !=
                              null &&
                          !ZekrController.instance.isFreeMode.value)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            ZekrController.instance.selectedZekr.value.note!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      Visibility(
                        visible: !ZekrController.instance.isFreeMode.value,
                        child: const SizedBox(height: 12),
                      ),
                      Visibility(
                        visible: !ZekrController.instance.isFreeMode.value,
                        child: Obx(
                          () => Text(
                            "التكرار: ${ZekrController.instance.currentRound.value}/${ZekrController.instance.selectedZekr.value.totalRounds} - "
                            "التسبيحات: ${ZekrController.instance.currentCount.value}/${ZekrController.instance.selectedZekr.value.repeatPerRound}",
                            style: const TextStyle(
                              fontSize: 14.5,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // زر تغيير الذكر (مخفي في الوضع الحر)
            Obx(
              () => Visibility(
                visible: !ZekrController.instance.isFreeMode.value,
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRouteName.sibhaAzkar),
                  child: Text(
                    "تغيير الذكر",
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            // الزر الدوّار
            RotatingSibhaButton(controller: ZekrController.instance),

            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.refresh, color: AppColor.blueTint2),
                  onPressed: () {
                    if (ZekrController.instance.isFreeMode.value) {
                      ZekrController.instance.totalCounter.value = 0;
                    } else {
                      ZekrController.instance.resetAll();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share, color: AppColor.primary),
                  onPressed: ZekrController.instance.shareAchievement,
                ),
                Obx(
                  () => Visibility(
                    visible: !ZekrController.instance.isFreeMode.value,
                    child: IconButton(
                      icon: Icon(Icons.bar_chart, color: AppColor.primary),
                      onPressed: () => Get.to(() => const SibhaStatsView()),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
} //-----------------------------------------------------------------------------

// صفحة إحصائيات السبحة – لا تغييرات جوهرية لكن نحسّن عرض النص الطويل في الرسم
//-----------------------------------------------------------------------------
class SibhaStatsView extends StatefulWidget {
  const SibhaStatsView({super.key});

  @override
  State<SibhaStatsView> createState() => _SibhaStatsViewState();
}

class _SibhaStatsViewState extends State<SibhaStatsView> {
  Future<List<dynamic>>? _future;
  bool isStatisticsEmpty = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _future = Future.wait([loadStats(), loadTotals()]);
  }

  Future<Map<String, Map<String, int>>> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    final stats = <String, Map<String, int>>{};
    for (final key in prefs.getKeys().where((k) => k.startsWith('stats_'))) {
      final date = key.replaceFirst('stats_', '');
      for (final line in prefs.getStringList(key) ?? []) {
        final parts = line.split('|');
        if (parts.length == 2) {
          final zekr = parts[0];
          final count = int.tryParse(parts[1]) ?? 0;
          stats.putIfAbsent(date, () => {});
          stats[date]![zekr] = (stats[date]![zekr] ?? 0) + count;
        }
      }
    }
    return stats;
  }

  Future<Map<String, int>> loadTotals() async {
    final prefs = await SharedPreferences.getInstance();
    final totals = <String, int>{};
    for (final key in prefs.getKeys()) {
      if (key.startsWith('total_')) {
        final zekr = key.replaceFirst('total_', '');
        totals[zekr] = prefs.getInt(key) ?? 0;
      }
    }
    return totals;
  }

  Future<void> clearAllStats() async {
    if (!isStatisticsEmpty) {
      Get.defaultDialog(
        title: "تأكيد الحذف",
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("هل أنت متأكد من حذف كافة الإحصائيات؟"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // زر «لا» بإطار فقط (اختر إحدى الطريقتين)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // خلفية بيضاء
                      elevation: 0, // بدون ظل
                      foregroundColor: AppColor.primary, // لون النص
                      shape: RoundedRectangleBorder(
                        // ⬅️ نصف القُطر أكبر ليظهر التدوير بوضوح
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          // الحدّ الملوّن
                          color: AppColor.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text("لا"),
                  ),
                  SizedBox(width: 20.w),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                    ),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      for (final key in prefs.getKeys()) {
                        if (key.startsWith('stats_') ||
                            key.startsWith('total_')) {
                          await prefs.remove(key);
                        }
                      }
                      Get.back();
                      setState(_loadData);
                      Get.snackbar(
                        "تم الحذف",
                        "تم حذف كافة الإحصائيات بنجاح.",
                        backgroundColor: AppColor.lightGrey.withOpacity(0.3),
                      );
                    },
                    child: const Text(
                      "نعم",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }else {
      showToast("لا توجد إحصائيات لحذفها.", AppColor.primary.withOpacity(0.9));
   
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColor.white),
        ),
        backgroundColor: AppColor.primary,
        title: const Text(
          "إحصائيات التسبيح",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: clearAllStats,
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _future,
        builder: (ctx, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final daily = snap.data![0] as Map<String, Map<String, int>>;
          final total = snap.data![1] as Map<String, int>;
          if (daily.isEmpty && total.isEmpty) {
            isStatisticsEmpty = true;
            return Center(
              child: Text(
                "لا يوجد إحصائيات بعد ...",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (total.isNotEmpty) ...[
                const Text(
                  "الإجمالي لكل ذكر:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...total.entries.map(
                  (e) => ListTile(
                    title: Text(e.key),
                    trailing: Text(e.value.toString()),
                  ),
                ),
                const Divider(),
              ],
              const Text(
                "الإحصائيات اليومية:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...daily.entries.map(
                (e) => ExpansionTile(
                  title: Text(e.key),
                  children:
                      e.value.entries
                          .map(
                            (x) => ListTile(
                              title: Text(x.key),
                              trailing: Text(x.value.toString()),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    total.isNotEmpty
                        ? () => Get.to(
                          () =>
                              StatsChart(totalStats: total, dailyStats: daily),
                        )
                        : () => Get.snackbar(
                          "خطأ",
                          "لا توجد إحصائيات لعرض الرسم البياني.",
                          backgroundColor: AppColor.lightGrey.withOpacity(0.3),
                        ),
                child: const Text("عرض الرسم البياني"),
              ),
            ],
          );
        },
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// صفحة الرسم البياني
//-----------------------------------------------------------------------------
class StatsChart extends StatefulWidget {
  final Map<String, int> totalStats;
  final Map<String, Map<String, int>> dailyStats;
  const StatsChart({
    super.key,
    required this.totalStats,
    required this.dailyStats,
  });

  @override
  State<StatsChart> createState() => _StatsChartState();
}

class _StatsChartState extends State<StatsChart> {
  final List<Color> _piePalette = [
    Colors.blue.shade800.withOpacity(0.95),
    Colors.indigo.shade600.withOpacity(0.9),
    Colors.blue.shade500.withOpacity(0.85),
    Colors.cyan.shade500.withOpacity(0.8),
    Colors.teal.shade400.withOpacity(0.75),
    Colors.lightBlue.shade300.withOpacity(0.7),
  ];

  Map<String, int> get _mergedDaily {
    final Map<String, int> merged = {};
    widget.dailyStats.values.forEach((map) {
      map.forEach((k, v) => merged[k] = (merged[k] ?? 0) + v);
    });
    return merged;
  }

  @override
  Widget build(BuildContext context) {
    final totalCount = widget.totalStats.values.fold<int>(0, (a, b) => a + b);
    final topZekr =
        widget.totalStats.isNotEmpty
            ? widget.totalStats.entries
                .reduce((a, b) => a.value > b.value ? a : b)
                .key
            : "لا يوجد";
    final activeDays = widget.dailyStats.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'رسم بياني الإحصائيات',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoCard(
                    'إجمالي التسبيحات',
                    totalCount.toString(),
                    Icons.format_list_numbered,
                  ),
                  _infoCard('أكثر ذكر', topZekr, Icons.star),
                  _infoCard(
                    'أيام النشاط',
                    activeDays.toString(),
                    Icons.calendar_today,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _bar(
                '📊 إجمالي التسبيحات لكل ذكر',
                widget.totalStats,
                Colors.indigoAccent,
              ),
              const SizedBox(height: 30),
              _bar('📅 إجمالي التسبيحات يوميًا', _mergedDaily, Colors.teal),
              const SizedBox(height: 30),
              _pie(widget.totalStats, '📈 التوزيع النسبي للأذكار '),
              const SizedBox(height: 16),
              _buildLegend(widget.totalStats),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String label, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 110,
        child: Column(
          children: [
            Icon(icon, color: AppColor.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar(String title, Map<String, int> data, Color color) {
    final keys = data.keys.toList();

    final barGroups =
        data.entries.map((e) {
          final i = keys.indexOf(e.key);
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: e.value.toDouble(),
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.7), color],
                ),
                width: 24, // ← كان 20
                borderRadius: BorderRadius.circular(6),
              ),
            ],
            showingTooltipIndicators: const [0],
          );
        }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 340, // ← كان 280
          child: BarChart(
            BarChartData(
              barGroups: barGroups,
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 80, // ↑ مساحة أكبر لعناوين X
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < keys.length) {
                        final label = keys[index];
                        return Transform.rotate(
                          angle: -0.5, // ↓ زاوية أقل حِدّة
                          child: SizedBox(
                            width: 70,
                            child: Text(
                              label, // الاسم كامل (يُقصّ تلقائيًا لو طويل)
                              maxLines: 2, // سطران لإظهار قدر أكبر
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget:
                        (v, meta) => Text(
                          v.toInt().toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              gridData: FlGridData(show: true),
              maxY:
                  data.isNotEmpty
                      ? data.values.reduce((a, b) => a > b ? a : b) * 1.3
                      : 10,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.grey.shade700,
                  getTooltipItem:
                      (g, gi, rod, ri) => BarTooltipItem(
                        '${rod.toY.toInt()}',
                        const TextStyle(color: Colors.white),
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _pie(Map<String, int> data, String title) {
    if (data.isEmpty) return const SizedBox.shrink();
    final total = data.values.fold<int>(0, (a, b) => a + b);
    final entries = data.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _piePalette[1],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 240,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: List.generate(entries.length, (i) {
                final percent = entries[i].value / total * 100;
                return PieChartSectionData(
                  value: percent,
                  title:
                      '''${entries[i].value}\n(${percent.toStringAsFixed(1)}%)''',
                  titlePositionPercentageOffset: 0.6,
                  color: _piePalette[i % _piePalette.length],
                  radius: 60,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    height: 1.2,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(Map<String, int> data) {
    if (data.isEmpty) return const SizedBox.shrink();
    final entries = data.entries.toList();
    final pairs = <List<MapEntry<String, int>>>[];
    for (int i = 0; i < entries.length; i += 2) {
      final pair = [entries[i]];
      if (i + 1 < entries.length) pair.add(entries[i + 1]);
      pairs.add(pair);
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            pairs.map((pair) {
              return Row(
                children:
                    pair.map((e) {
                      final index = entries.indexOf(e);
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                color: _piePalette[index % _piePalette.length],
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  e.key,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              );
            }).toList(),
      ),
    );
  }
}
