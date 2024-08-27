import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../bussniess_logic/note_cubit/note_cubit.dart';
import '../../bussniess_logic/overlay_note_control/overlay_note_control_cubit.dart';
import '../../data/models/note_model.dart';
import 'overlay_note_component.dart';

class NoteAyah extends StatelessWidget {
  const NoteAyah({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${noteModel.surahName} - الايه ${noteModel.ayahNum.toString().toArabic}",
                          style: const TextStyle(
                            color: AppColor.blueColor,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'naskh',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 130.w,
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            noteModel.note,
                            softWrap: true,
                            style: const TextStyle(
                              color: AppColor.blueColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Container(
                        width: 28,
                        height: 26,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                            color: AppColor.blueColor.withOpacity(0.85),
                            shape: BoxShape.circle),
                        child: Text(
                          noteModel.pageNum.toArabic,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'naskh',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      
          GestureDetector(
            onTap: () {
              context.read<OverlayNoteControlCubit>().toggle();
            },
            child: BlocBuilder<OverlayNoteControlCubit, bool>(
              builder: (context, isExpanded) {
                return Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: isExpanded
                      ? const Icon(
                          Icons.close,
                          size: 22,
                          color: AppColor.blueColor,
                        )
                      : Image.asset(
                          AppImages.menu,
                          width: 21,
                          height: 21,
                          color: AppColor.blueColor,
                        ),
                );
              },
            ),
          ),
       
                    ],
                  ),
                ],
              ),
            ),
          ),
          //

          // BlocBuilder<OverlayNoteControlCubit, bool>(
          //   builder: (context, state) {
          //     return Visibility(
          //       visible: state,
          //       child: Container(
          //         width: Get.width,
          //         height: 75,
          //         color: Colors.black38,
          //       ),
          //     );
          //   },
          // ),
           ],
      ),
    );
  }
}
