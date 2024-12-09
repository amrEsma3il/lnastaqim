import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';

// import '../../../../core/constants/images.dart';
class SurahInfoWidget extends StatelessWidget {
  const SurahInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = SurahPlayerCubit.get(context);

    return Container(
      width: Get.width,
      height: 515,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        image: DecorationImage(
          alignment: Alignment.center,
          image: const AssetImage('assets/images/reciter_10.png'),
          fit: BoxFit.cover,
          opacity: 0.9,
          colorFilter: ColorFilter.mode(
            AppColor.blueColor.withOpacity(0.9),
            BlendMode.modulate,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 215,
            height: 215,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(400),
              image: DecorationImage(
                alignment: Alignment.center,
                image: const AssetImage('assets/images/reciter_10.png'),
                fit: BoxFit.cover,
                opacity: 0.9,
                colorFilter: ColorFilter.mode(
                  AppColor.blueColor.withOpacity(0.65),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "القارئ ياسين",
            style: TextStyle(
                fontSize: 24.sp,
                color: AppColor.lightBlue,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                //  isScrollControlled: true, 
  enableDrag: false,
                context: context,
                backgroundColor: AppColor.blueColor,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (bottomSheetContext) {
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
                                cursorColor:AppColor.lightBlue,
                                cursorRadius: const Radius.circular(10),  // تغيير لون الكيرسور إلى الأزرق
                              
                                                    
                              ),
                            ),
                            SizedBox(width: 14.w,),

  GestureDetector(
    onTap: () {
                  cubit.clearSearch();
                 Get.back(); // Close the bottom sheet
                },
    child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1), // Set your desired background color
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
                            value:cubit,
                            child:
                                BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
                              builder: (context, state) {
                                final results = state.searchResults.isEmpty
                                    ? SurahPlayerCubit.quranSurahs.keys.toList()
                                    : state.searchResults;

                                return ListView.builder(
                                  itemCount: results.length,
                                  itemBuilder: (context, index) {
                                    final surahNumber = results[index];
                                    final surahName = SurahPlayerCubit
                                        .quranSurahs[surahNumber]!;
                                    return ListTile(
                                      selected: surahNumber==state.surahNumber,
                                      selectedTileColor:Colors.white.withOpacity(0.1),
                                      title: Text(surahName,   
                                       style: const TextStyle(color: Colors.white),
                                      ),
                                      trailing: const Icon(
                                        Icons.music_note_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      onTap: () {
                                        context
                                            .read<SurahPlayerCubit>()
                                            .changeSurahNum(surahNumber);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
                  builder: (context, state) {
                    return Text(
                      SurahPlayerCubit.quranSurahs[state.surahNumber]
                          .toString(),
                      style: TextStyle(
                          fontSize: 16.5.sp,
                          color: AppColor.lightBlue,
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.lightBlue,
                  size: 17,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
