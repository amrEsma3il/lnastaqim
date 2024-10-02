import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/features/share/views/widgets/share_fun.dart';

import '../../../../core/constants/colors.dart';
import '../../../quran/data/models/surahs_model.dart';

class ShareAyahCheckBox extends StatefulWidget {
  const ShareAyahCheckBox(
      {Key? key, required this.selectedAyah, required this.ayahNumber})
      : super(key: key);

  final Ayah selectedAyah;
  final String ayahNumber;

  @override
  State<ShareAyahCheckBox> createState() => _ShareAyahCheckBoxState();
}

class _ShareAyahCheckBoxState extends State<ShareAyahCheckBox> {
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
                  activeColor: Colors.transparent,
                   side: MaterialStateBorderSide.resolveWith(
    (states) => const BorderSide(
      color:Colors.white, // Change border color based on state
      width: 1, // Set the width of the border
    ),
  ),
                  value: _isTextChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isTextChecked = value!;
                      _isImageChecked = !value;
                    });
                  },
                ),
                title: const Text('نص',style: TextStyle(color: Colors.white,fontSize: 16)),
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
                  activeColor: AppColor.transparent,
                                     side: MaterialStateBorderSide.resolveWith(
    (states) => const BorderSide(
      color:Colors.white, // Change border color based on state
      width: 1, // Set the width of the border
    ),
  ),
                  value: _isImageChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isImageChecked = value!;
                      _isTextChecked = !value;
                    });
                  },
                ),
                title: const Text('صورة',style: TextStyle(color: Colors.white,fontSize: 16),),
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
         SizedBox(height: 28.h),
        GestureDetector(
          onTap: () {
            if (_isTextChecked) {
              shareText(widget.selectedAyah.text);
            } else if (_isImageChecked) {
              shareAyahAsImage(widget.ayahNumber, context, widget.selectedAyah);
            } else {
              print("No option selected");
            }
          },
          child: Container(
            height: 45,
            width: 83,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Center(
              child: Text(
                'مشاركة',
                style: TextStyle(color:AppColor.blueColor,fontSize: 17,fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
