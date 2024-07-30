import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/local_database/tafaseer/tabri.dart';
import 'package:lnastaqim/core/utilits/extensions/color_from_hex.dart';
import '../../../../core/constants/colors.dart';
import '../../bussniess_logic/tafseer_cubit.dart';
import '../widget/toggle_button.dart';

class TafseerScreen extends StatelessWidget {
  const TafseerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          TafseerCubit.get(context).getAyaTafasser(
              TafseerCubit.get(context).ayanumber!,
              TabriTafseer.tafaseerJasonData);
          showModalBottomSheet(
            context: context,
            backgroundColor:AppColor.rhino,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(48.r),
                    topLeft: Radius.circular(48.r))),
            builder: (context) => SizedBox(
              height: 500.h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const ToggleButton(),
                      SizedBox(
                        height: 20.h,
                      ),
                      BlocBuilder<TafseerCubit, String>(
                        builder: (context, state) {
                          return TafseerCubit.get(context).tafsir == false
                              ? Text(
                                  '${TafseerCubit.get(context).getAyaTafasser(TafseerCubit.get(context).ayanumber!, TabriTafseer.tafaseerJasonData)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  state,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        icon: Icon(
          Icons.menu_book_rounded,
          color: "#404c6e".toColor,
        ));
  }
}
