import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import '../../../../core/utilits/widgets/surah_banner.dart';
import '../../bussniess_logic/sowra_detail/sora_details_cubit.dart';
import '../../data/models/quran_model.dart';

class SoraDetails extends StatelessWidget {
  final SoraModel soraModel;
  const SoraDetails({super.key, required this.soraModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 221, 228, 242),
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
                  height: 10.h,
                ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: SizedBox(height: 62.h,width: Get.width,
                  child: Stack(alignment: Alignment.center,
                    children: [
                      Container(width: Get.width,height:75.h ,color:  Color.fromARGB(223, 201, 185, 223),),
                           Positioned(top: 0.h,
                        child: Container(width:Get.width,height: 11.h,color: const Color.fromARGB(228, 148, 114, 196),)),
                      Positioned(bottom: 0.h,
                        child: Container(width: Get.width,height: 11.h,color: const Color.fromARGB(228, 148, 114, 196),)),
                       Positioned(right: 0,
                         child: CustomPaint(
                          size: Size(130.w,135.h), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: RPSCustomPainter(),
                                               ),
                       ),
                     
                      Positioned(left: 0,
                        child: CustomPaint(
                          size: Size(130.w,130.h), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: LPSCustomPainter(),
                        ),
                      ),
                 


                       Center(
                         child: Text(' سُورَةُ ${soraModel.name!}',
                           textAlign: TextAlign.center,
                           style: TextStyle(
                            wordSpacing: -2,
                               fontSize: 26.sp,
                               fontWeight: FontWeight.w600,
                               fontFamily: "Authmanic")),
                       ),
                    ],
                  ),
                ),
              ), 
              SizedBox(height: 5.h),
              Center(child: Text(" ﷽",style: TextStyle(
                               fontSize: 22.sp,
                               fontWeight: FontWeight.w600,
                               fontFamily: "Amiri")),),
                                 SizedBox(height: 7.h),
                Container(width: Get.width-40,
                    padding:
                        EdgeInsets.symmetric( vertical: 2.h),
                    child: BlocBuilder<QuranSowarVersusCubit, int>(
                      builder: (context, state) {
                        return RichText(
                            selectionColor: AppColor.softGray,
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                                style: TextStyle(
                                    wordSpacing: -4.w,
                                    height: 1.3.h,
                                    color: AppColor.black,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Authmanic"),
                                children: [
                                  for (int index = 0;
                                      index <= soraModel.array!.length - 1;
                                      index++) ...{
                                    TextSpan(
                                        style: TextStyle(
                                            backgroundColor: state == index
                                                ?  const Color.fromARGB(255, 148, 139, 204)
                                                : Colors.transparent),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            BlocProvider.of<
                                                        QuranSowarVersusCubit>(
                                                    context)
                                                .selectedVerse(index);

                                                Future.delayed(const Duration(seconds: 10));
                                            showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  48.r),
                                                          topLeft:
                                                              Radius.circular(
                                                                  48.r))),
                                              builder: (context) => SizedBox(
                                                height: 240.h,
                                                child: Center(
                                                  child: Text(
                                                    " رقم الاية${(index + 1).toString().toArabic}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 24.sp),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        text: "${soraModel.array![index].ar}"),
//${(0 + 1).toString().toArabic}
                                    TextSpan(
                                    
                                       
                                        text:  " ${(index+1).toString().toArabic} ",
                                          style: TextStyle(
                                      
                                           
                                       fontSize: 29.sp,
                                            color: const Color.fromARGB(255, 101, 88, 182),
                                            
                                          ),
                                        )
                                  }
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




