import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';

class SurahsBottomSheetComponent extends StatelessWidget {
  const SurahsBottomSheetComponent({super.key, required this.cubit});

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
                child: TextField(
                  onChanged: (value) => cubit.searchSurahs(value),
                  decoration: InputDecoration(
                    hintText: 'ابحث عن سورة...',
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: AppColor.lightBlue,
                  cursorRadius: const Radius.circular(
                    10,
                  ), // تغيير لون الكيرسور إلى الأزرق
                ),
              ),
              SizedBox(width: 14.w),
              GestureDetector(
                onTap: () {
                  Get.back();
                  cubit.clearSurahSearch();
                  // Close the bottom sheet
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.1,
                    ), // Set your desired background color
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 19),
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
                  final results = state.searchSurahResults;

                  return Visibility(
                    visible: results.isNotEmpty,
                    replacement: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(0, 3, 2, 2),
                      ),
                      child: Center(
                        child: Text(
                          "لا توجد سور",
                          style: TextStyle(
                            color: AppColor.lightBlue,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final surahNumber = results[index];
                        final surahName =
                            SurahPlayerCubit.quranSurahs[surahNumber]!;
                        return ListTile(
                          selected: surahNumber == state.surahNumber,
                          selectedTileColor: Colors.white.withOpacity(0.1),
                          title: Text(
                            surahName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.music_note_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          onTap: () async {
                            Get.back();
                            await Future.delayed(
                              const Duration(milliseconds: 200),
                            );
                            await cubit.changeSurahNum(surahNumber);
                            cubit.clearSurahSearch();
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
