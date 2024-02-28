import 'package:flutter/material.dart';

class PrayersStepper extends StatelessWidget {
  const PrayersStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          StepperItem(title: 'الفجر'),
          StepperItem(title: 'الظهر'),
          StepperItem(title: 'العصر'),
          StepperItem(title: 'المغرب'),
          StepperItem(title: 'العشاء'),
        ],
      ),
    );
  }
}

class StepperItem extends StatelessWidget {
  const StepperItem({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(title),
          const Text('05:00 AM'),
          const SizedBox(height: 10),
          Row(
            children: [
              title == 'الفجر'
                  ? const Expanded(child: SizedBox())
                  : const Line(),
              const Step(),
              title == 'العشاء'
                  ? const Expanded(child: SizedBox())
                  : const Line(),
            ],
          ),
          const SizedBox(height: 10),
          const Icon(Icons.wb_sunny_outlined)
        ],
      ),
    );
  }
}

class Line extends StatelessWidget {
  final bool isChecked;
  const Line({super.key, this.isChecked = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 2,
      color: isChecked ? Colors.orange : Colors.grey,
    ));
  }
}

class Step extends StatelessWidget {
  final bool isChecked;
  const Step({super.key, this.isChecked = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isChecked ? Colors.orange : null,
          border: Border.all(
            color: Colors.orange,
            width: 2,
          )),
      child: isChecked
          ? const Icon(
              Icons.check,
              color: Colors.white,
            )
          : null,
    );
  }
}
