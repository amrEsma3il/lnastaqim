import 'package:flutter/material.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';
import 'package:lnastaqim/features/calender/view/widgets/calendar_footer.dart';
import 'package:lnastaqim/features/calender/view/widgets/calender_header.dart';
import 'package:lnastaqim/features/calender/view/widgets/custom_calender.dart';
import 'package:lnastaqim/features/calender/view/widgets/hijri_calender.dart';

// State
class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  bool _isGre = true;
  bool _isHijri = false;

  void _toggleGre() {
    setState(() {
      _isGre = true;
      _isHijri = false;
    });
  }

  void _toggleHijri() {
    setState(() {
      _isGre = false;
      _isHijri = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "التقويم",
        isLayout: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalenderHeader(
                  text: "التقويم الميلادي",
                  isSelected: _isGre,
                  onTap: _toggleGre,
                ),
                const SizedBox(
                  width: 16,
                ),
                CalenderHeader(
                  text: "التقويم الهجري",
                  isSelected: _isHijri,
                  onTap: _toggleHijri,
                ),
              ],
            ),
          ),
          Visibility(
            visible: _isGre,
            child: CustomCalender(
              onDaySelected: (value) {},
            ),
          ),
          Visibility(
            visible: _isHijri,
            child: CustomHijriCalendar(
              onDaySelected: (value) {},
            ),
          ),
          const Spacer(),
          const CalendarFooter(),
        ],
      ),
    );
  }
}
