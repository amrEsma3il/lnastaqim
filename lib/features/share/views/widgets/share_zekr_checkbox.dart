import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/share/views/widgets/share_fun.dart';

class ShareZekrCheckBox extends StatefulWidget {
  const ShareZekrCheckBox({
    super.key,
    required this.zekr,
    required this.image,
    required this.zekrLink,
  });

  final String zekr;
  final Uint8List image;
  final String zekrLink;

  @override
  State<ShareZekrCheckBox> createState() => _ShareZekrCheckBoxState();
}

class _ShareZekrCheckBoxState extends State<ShareZekrCheckBox> {
  bool _isTextChecked = true;
  bool _isImageChecked = false;
  bool _isLinkChecked = false;

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
                  side: WidgetStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  activeColor: AppColor.transparent,
                  value: _isTextChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isTextChecked = value!;
                      _isImageChecked = !value;
                      _isLinkChecked = !value;
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
                    _isLinkChecked = false;
                  });
                },
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Checkbox(
                  side: WidgetStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  activeColor: AppColor.transparent,
                  value: _isImageChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isImageChecked = value!;
                      _isTextChecked = !value;
                      _isLinkChecked = !value;
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
                    _isLinkChecked = false;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: ListTile(
            leading: Checkbox(
              activeColor: Colors.transparent,
              side: WidgetStateBorderSide.resolveWith(
                (states) => const BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              value: _isLinkChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isTextChecked = !value!;
                  _isImageChecked = !value;
                  _isLinkChecked = value;
                });
              },
            ),
            title: const Text('رابط',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            onTap: () {
              setState(() {
                _isTextChecked = false;
                _isImageChecked = false;
                _isLinkChecked = true;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () async {
            if (_isTextChecked) {
              shareText(widget.zekr);
            } else if (_isImageChecked) {
              await shareImage(widget.image, "zekr");
            } else if (_isLinkChecked) {
              shareText(widget.zekrLink);
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
