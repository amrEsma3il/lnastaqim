import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../../../quran/bussniess_logic/quran/quran_cubit.dart';
import '../../../quran/bussniess_logic/screen_tap_Visibility/screen_tap_visability.dart';

class NoteCollection extends StatelessWidget {
  const NoteCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
     QuranCubit.get(context).clearScreen(context);
        // Get.offNamed(AppRouteName.note);
        Get.back();
        ScreenOverlayCubit.showMoshafNotes(context);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: const Row(
          children: [
            Text(
              "الملاحظات",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color:AppColor.blueColor),
            ),
            Spacer(),
            Icon(Icons.note_alt_outlined, color: AppColor.blueColor,size: 27,),
          ],
        ),
      ),
    );
  }
}
