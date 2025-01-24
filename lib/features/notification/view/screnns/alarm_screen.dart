
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';

class AlarmApp extends StatelessWidget {
  const AlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AlarmScreen(),
    );
  }
}

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _setAlarm() async {
    if (selectedTime != null) {
      final now = DateTime.now();
      final alarmTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      // إعداد المنبه
      final alarmSettings = AlarmSettings(
        id: 1, // معرف المنبه
        dateTime: alarmTime,
        assetAudioPath: 'assets/sounds/azhan.mp3', // ملف الصوت (يوضع داخل مجلد assets)
        // تكرار الصوت
        vibrate: true, // تفعيل الاهتزاز
        fadeDuration: 3.0, // مدة خفض الصوت التدريجي
        notificationTitle: 'منبه', // عنوان الإشعار
        notificationBody: 'حان وقت التنبيه!', // نص الإشعار
        enableNotificationOnKill: true, // استمرارية الإشعار عند قتل التطبيق
      );

      // ضبط المنبه
      await Alarm.set(alarmSettings: alarmSettings);

  if(mounted)   { ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم ضبط المنبه بنجاح!')),
      );
    }}
  }

  Future<void> _cancelAlarm() async {
    await Alarm.stop(1); // إيقاف المنبه باستخدام معرفه
    if(mounted)  {ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إلغاء المنبه.')),
    );}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('منبه')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('توقيت:'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        selectedTime = time;
                      });
                    }
                  },
                  child: Text(selectedTime != null
                      ? selectedTime!.format(context)
                      : 'اختيار الوقت'),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _setAlarm,
                    child: const Text('ضبط المنبه'),
                  ),
                  ElevatedButton(
                    onPressed: _cancelAlarm,
                    child: const Text('إلغاء المنبه'),
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