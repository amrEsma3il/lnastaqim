import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/share/views/widgets/share_fun.dart';

class ShareHadisCheckbox extends StatefulWidget {
  const ShareHadisCheckbox({
    super.key,
    required this.hadis,
    required this.category,
  });

  final String hadis;

  final String category;

  @override
  State<ShareHadisCheckbox> createState() => _ShareHadisCheckboxState();
}

class _ShareHadisCheckboxState extends State<ShareHadisCheckbox> {
  bool _isTextChecked = true;
  bool _isImageChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: Checkbox(
                  side: BorderSide(color: AppColor.white),
                  checkColor: AppColor.primary,
                  activeColor: AppColor.white,
                  value: _isTextChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isTextChecked = value!;
                      _isImageChecked = !value;
                    });
                  },
                ),
                title: const Text(
                  'نص',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    _isTextChecked = true;
                    _isImageChecked = false;
                  });
                },
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Checkbox(
                  side: BorderSide(color: AppColor.white),
                  checkColor: AppColor.primary,
                  activeColor: AppColor.white,
                  value: _isImageChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isImageChecked = value!;
                      _isTextChecked = !value;
                    });
                  },
                ),
                title: const Text(
                  'صورة',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    _isImageChecked = true;
                    _isTextChecked = false;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () async {
            if (_isTextChecked) {
              shareText(widget.hadis);
            } else if (_isImageChecked) {
              await shareHadisAsImage(widget.hadis, widget.category, context);
            } else {
              print("No option selected");
            }
          },
          child: Container(
            height: 40,
            width: 70,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Center(
              child: Text(
                'مشاركة',
                style: TextStyle(color: Color(0xff404c6e)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
