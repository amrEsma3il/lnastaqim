
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../bussniess_logic/quran/quran_cubit.dart';
import '../../bussniess_logic/quran_sowar/search_or_not_cubit.dart';
import '../../data/models/search_ayah_entity.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = QuranCubit.get(context);
    return BlocBuilder<SearchOrNot, bool>(
      builder: (context, searchState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  List<SearchAyahEntity>  searchResult= cubit.searchInMoshaf(searchText: 'بقرة');
                  print(searchResult.length);
                  print(searchResult.map((e) => e.aya.text));

                  //   searchResult.forEach((ayaInfo) {
                  //   print(ayaInfo.aya.text);
                  //
                  // });
                  // BlocProvider.of<SearchOrNot>(context).swithSearchStatus();
                },
                icon: Icon(
                  searchState ? Icons.cancel_outlined : Icons.search,
                  size: 27,
                  color: AppColor.brownBackground,
                )),
            Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeIn,
                  margin: EdgeInsets.only(left: 11.w),
                  height: 40.h,
                  width: searchState ? 265.w : 0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(width: 1, color: AppColor.softGray)),
                  child: TextFormField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 13.w, 13.h),
                      hintText: searchState ? 'بحث' : '',
                      constraints:
                          BoxConstraints(maxHeight: 40.h, maxWidth: 240),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 90),
                  opacity: searchState ? 0 : 1,
                  curve: Curves.easeInBack,
                  child: Text(
                    'القرآن الكريم',
                    style: TextStyle(
                        color: AppColor.brownText,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 9.w, bottom: 1.h),
              child: Image.asset(
                AppImages.burgarMark,
                width: 23.w,
                height: 23.h,
              ),
            )
          ],
        );
      },
    );
  }
}
