

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/colors.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';

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
