import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';
import 'country_filter_component.dart';

class RecitersBottomSheetComponent extends StatelessWidget {
  const RecitersBottomSheetComponent({
    super.key,
    required this.cubit,
  });

  final SurahPlayerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) =>
                              cubit.searchReciters(query: value),
                          decoration: const InputDecoration(
                            hintText: 'ابحث عن قارئ...',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.search, color: Colors.white),
                            border: InputBorder
                                .none, // Remove the decoration border
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: AppColor.lightBlue,
                          cursorRadius: const Radius.circular(
                              10), // تغيير لون الكيرسور إلى الأزرق
                        ),
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      CountryFilterComponent(
                        cubit: cubit,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 14.w,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  cubit.clearReciterSearch();
                  // Close the bottom sheet
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.1), // Set your desired background color
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocProvider.value(
              value: cubit,
              child: BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
                builder: (context, state) {
                  final results = state.searchReciterResults;

                  return Visibility(
                    visible: results.isNotEmpty,
                    replacement: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: Center(
                          child: Text("لا يوجد قراء",
                              style: TextStyle(
                                  color: AppColor.lightBlue,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold))),
                    ),
                    child: ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final reciter = results[index];
                        // final surahName =
                        //     SurahPlayerCubit.quranSurahs[surahNumber]!;
                        return ListTile(
                          selected: reciter.name == state.reciter.name,
                          selectedTileColor: Colors.white.withOpacity(0.1),
                          title: Text(
                            reciter.nameArabic,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: SvgPicture.asset(
                            SurahPlayerCubit.getCountryFlag(reciter
                                .nationality), // استبدل بالمسار المناسب لملف الـ SVG
                            // color: AppColor.lightBlue, // تغيير اللون
                            width: 17, // تحديد الحجم
                            height: 17, // تحديد الحجم
                          ),
                          onTap: () {
                            // Get.back();
                            cubit.changeReciter(reciter);

                            cubit.clearReciterSearch();
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
