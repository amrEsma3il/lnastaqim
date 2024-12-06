import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class SettingItem extends StatefulWidget {
  const SettingItem(
      {super.key,
      required this.icon,
      required this.text,
      this.onTap,
      this.isTheme});

  final IconData icon;
  final String text;
  final void Function()? onTap;
  final bool? isTheme;

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, right: 16, left: 16),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: AppColor.primary,
            ),
            const SizedBox(width: 20),
            Text(
              widget.text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            if (widget.isTheme == false) const Icon(Icons.arrow_forward_ios),
            if (widget.isTheme == true)
              Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
                activeColor: AppColor.white,
                activeTrackColor: AppColor.primary,
                inactiveThumbColor: AppColor.white,
                inactiveTrackColor: AppColor.gray,
              ),
          ],
        ),
      ),
    );
  }
}
