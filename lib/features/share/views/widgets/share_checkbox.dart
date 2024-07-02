import 'package:flutter/material.dart';
import 'package:lnastaqim/features/share/views/widgets/share_fun.dart';

import '../../../quran/data/models/surahs_model.dart';

class ShareCheckBox extends StatefulWidget {
  const ShareCheckBox(
      {Key? key, required this.ayahNumber, required this.selectedAyah})
      : super(key: key);

  final String ayahNumber;
  final Ayah selectedAyah;

  @override
  State<ShareCheckBox> createState() => _ShareCheckBoxState();
}

class _ShareCheckBoxState extends State<ShareCheckBox> {
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
                  activeColor: const Color(0xff404c6e),
                  value: _isTextChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isTextChecked = value!;
                      _isImageChecked = !value;
                    });
                  },
                ),
                title: const Text('نص'),
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
                  activeColor: const Color(0xff404c6e),
                  value: _isImageChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isImageChecked = value!;
                      _isTextChecked = !value;
                    });
                  },
                ),
                title: const Text('صورة'),
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
          onTap: () {
            if (_isTextChecked) {
              shareAyahText(widget.selectedAyah);
            } else if (_isImageChecked) {
              shareAyahAsImage(widget.ayahNumber, context, widget.selectedAyah);
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
