import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import '../../bussniess_logic/sowra_detail/sora_details_cubit.dart';
import '../../data/models/quran_model.dart';

class SoraDetails extends StatelessWidget {
  final SoraModel soraModel;
  const SoraDetails({super.key, required this.soraModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.crame,
      body: SafeArea(
          child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(soraModel.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36.sp, fontFamily: "Authmanic")),
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 34.w, vertical: 34),
                    child: BlocBuilder<QuranSowarVersusCubit, int>(
                      builder: (context, state) {
                        return RichText(
                            selectionColor: AppColor.softGray,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 28.sp,
                                    fontFamily: "Authmanic"),
                                children: [
                                  ...List.generate(
                                      soraModel.array!.length,
                                      (index) => TextSpan(
                                          style: TextStyle(
                                              backgroundColor:
                                                  state == index + 1
                                                      ? AppColor.heighlightColor
                                                      : AppColor.crame),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              BlocProvider.of<
                                                          QuranSowarVersusCubit>(
                                                      context)
                                                  .selectedVerse(index + 1);
                                              showModalBottomSheet(
                                                isDismissible: false,
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    48.r),
                                                            topLeft:
                                                                Radius.circular(
                                                                    48.r))),
                                                builder: (context) => Center(
                                                  child: Text(
                                                      " رقم الاية${(index + 1).toString().toArabic}",
                                                      style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24.sp),
                                                      
                                                      ),
                                                ),
                                              );
                                            },
                                          text:
                                              "${soraModel.array![index].ar}${(index + 1).toString().toArabic}"))
                                ]));
                      },
                    ))
              ],
            )),
          ],
        ),
      )),
    );
  }
}
