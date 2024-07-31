import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/tafaseer/view/widget/tafsir_type.dart';

import '../../../../core/local_database/tafaseer/baghawy.dart';
import '../../../../core/local_database/tafaseer/ibnkatheer.dart';
import '../../../../core/local_database/tafaseer/qurtubi.dart';
import '../../../../core/local_database/tafaseer/tabri.dart';
import '../../bussniess_logic/change_tafseer._cubit.dart';
import '../../bussniess_logic/tafseer_cubit.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        BlocProvider(
          create: (BuildContext context) => ChangeTafseerCubit(),
          child: BlocBuilder<ChangeTafseerCubit, int>(
            builder: (BuildContext context, state) {
              return ToggleButtons(
                borderRadius: BorderRadius.circular(20.r),
                borderColor: Colors.white,
                fillColor: AppColor.blueColor,
                isSelected: List.generate(4,
                    (index) => ChangeTafseerCubit.get(context).state == index),
                onPressed: (int index) {
                  ChangeTafseerCubit.get(context).changeColor(index);
                },
                children: [
                  TafsirType(
                    name: 'الطبري',
                    onPressed: () {
                      ChangeTafseerCubit.get(context).changeColor(0);
                      TafseerCubit.get(context).tafsir = true;
                      TafseerCubit.get(context).getAyaTafasser(
                        TafseerCubit.get(context).ayanumber!,
                        TabriTafseer.tafaseerJasonData,
                      );
                    },
                  ),
                  TafsirType(
                    name: 'ابن كثير',
                    onPressed: () {
                      ChangeTafseerCubit.get(context).changeColor(1);
                      TafseerCubit.get(context).tafsir = true;
                      TafseerCubit.get(context).getAyaTafasser(
                        TafseerCubit.get(context).ayanumber!,
                        IbnKatheerTafseer.tafaseerJasonData,
                      );
                    },
                  ),
                  TafsirType(
                    name: 'البغوي',
                    onPressed: () {
                      ChangeTafseerCubit.get(context).changeColor(2);
                      TafseerCubit.get(context).tafsir = true;
                      TafseerCubit.get(context).getAyaTafasser(
                        TafseerCubit.get(context).ayanumber!,
                        BaghawyTafseer.tafaseerJasonData,
                      );
                    },
                  ),
                  TafsirType(
                    name: 'القرطبي',
                    onPressed: () {
                      ChangeTafseerCubit.get(context).changeColor(3);
                      TafseerCubit.get(context).tafsir = true;
                      TafseerCubit.get(context).getAyaTafasser(
                        TafseerCubit.get(context).ayanumber!,
                        QurtubiTafseer.tafaseerJasonData,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
