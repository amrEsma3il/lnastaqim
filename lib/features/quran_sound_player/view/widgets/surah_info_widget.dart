import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

          ////////////////
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
                  return RecitersBottomSheetComponent(cubit: cubit);
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
                  builder: (context, state) {
                    return Text(
                      state.reciter.nameArabic,
                      style: TextStyle(
                          fontSize: 17.5.sp,
                          color: AppColor.lightBlue,
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(width: 2),
                //Add  here country flag icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.lightBlue,
                  size: 16,
                ),
              ],
            ),
          ),

          //////////
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
                  return SurahsBottomSheetComponent(cubit: cubit);
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
                          fontSize: 14.5.sp,
                          color: AppColor.lightBlue,
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.lightBlue,
                  size: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SurahsBottomSheetComponent extends StatelessWidget {
  const SurahsBottomSheetComponent({
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
                      10), // تغيير لون الكيرسور إلى الأزرق
                ),
              ),
              SizedBox(
                width: 14.w,
              ),
              GestureDetector(
                onTap: () {
                   Get.back(); 
                  cubit.clearSurahSearch();
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
                  final results = state.searchSurahResults;

                  return Visibility(
                    visible: results.isNotEmpty,
                    replacement: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(0, 3, 2, 2)),
                      child: Center(
                          child: Text(
                        "لا توجد سور",
                        style: TextStyle(
                            color: AppColor.lightBlue,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      )),
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
                          onTap: () {
                            context
                                .read<SurahPlayerCubit>()
                                .changeSurahNum(surahNumber);
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
                            context
                                .read<SurahPlayerCubit>()
                                .changeReciter(reciter);
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

class CountryFilterComponent extends StatelessWidget {
  const CountryFilterComponent({super.key, required this.cubit});
  final SurahPlayerCubit cubit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showCountryMenu(context, cubit);
      },

      //problem that i want give it static width and when use expanded force it to full empty space .....i want only fit content not fit to empty parent space
      //TODO: MAKE FILTER RESPONSIVE =>WRAP CONTENT
      child: IntrinsicWidth(
        child: Container(
          padding:
              EdgeInsets.only(right: 7.8.w, bottom: 4.h, top: 4.h, left: 3.w),
          margin: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.lightBlue, width: 1),
          ),
          child: BlocProvider.value(
            value: cubit,
            child: BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
              builder: (context, state) {
                return Row(
                  children: [
                    SvgPicture.asset(
                      SurahPlayerCubit.recitersCountries[state.reciterCountry]!,
                      height: 22,
                      width: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      state.reciterCountry,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 13.5,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future showCountryMenu(BuildContext context, SurahPlayerCubit cubit) async {
    return await showMenu(
      shadowColor: Colors.black,
      context: context,
      position: const RelativeRect.fromLTRB(290, 185, 187, 10),
      items: SurahPlayerCubit.recitersCountries.entries.map((entry) {
        return PopupMenuItem(
          value: entry.key,
          child: Row(
            children: [
              SvgPicture.asset(entry.value, height: 30, width: 30),
              const SizedBox(width: 12),
              Text(
                entry.key,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        );
      }).toList(),
      elevation: 8.0,
      color: AppColor.blueColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ).then((selectedValue) {
      if (selectedValue != null && context.mounted) {
        log("from menu$selectedValue");
        cubit.searchReciters(country: selectedValue);
      }
    });
  }
}
