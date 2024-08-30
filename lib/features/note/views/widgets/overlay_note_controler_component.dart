import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class OverlayNoteControlElementComponent extends StatelessWidget {
    final bool isExpanded;
    final Offset offset;
    final IconData icon;

    final Color color;
    final VoidCallback onPressed;

  const OverlayNoteControlElementComponent({super.key, required this.isExpanded, required this.offset, required this.icon,  required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: isExpanded ? offset.dy : 0,
      right: isExpanded ? offset.dx : 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isExpanded ? 1 : 0,
        child: Container(
                         width: 31,
                  height: 33,
                  alignment: Alignment.center,
                  // margin: const EdgeInsets.only(right: 20),
               decoration:  BoxDecoration(color:  AppColor.blueColor.withOpacity(0.85),shape: BoxShape.circle),
                        child: Icon(icon,color: color,size: 22,),
                      ),
      ),
    );
  }
}