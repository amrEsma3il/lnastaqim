import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../bussniess_logic/quran/index_cubit/index_cubit.dart';
import '../../bussniess_logic/quran/index_cubit/index_state.dart';
import '../widgets/quran_sora_component.dart';

class MoshafIndex extends StatelessWidget {
  const MoshafIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<IndexCubit, IndexState>(
        builder: (context, state) {
               final List<dynamic> indexState =
                              state is SurahIndexState
                                  ? SurahIndexState.indexList
                                  : (state is ChapterIndexState
                                      ? ChapterIndexState.indexList
                                      : state is HizbIndexState
                                          ? HizbIndexState.indexList
                                          : SurahIndexState.indexList);
                                          final int selector =
                              state is SurahIndexState
                                  ? SurahIndexState.selrctor
                                  : (state is ChapterIndexState
                                      ? ChapterIndexState.selrctor
                                      : state is HizbIndexState
                                          ? HizbIndexState.selrctor
                                          : SurahIndexState.selrctor);
          return SizedBox(
            // height: 450,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: List.generate(
                          IndexCubit.moshafIndexTypes.length,
                          (index) => GestureDetector(
                            onTap: () {
                              IndexCubit.get(context).changeSelector(index);
                            },
                            child: SizedBox(
                              width: Get.width / 3 - 5,
                              child: Column(
                                    children: [
                                      Text(
                                        IndexCubit.moshafIndexTypes[index],
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.blueColor
                                                .withOpacity(0.9)),
                                      ),
                                      Container(
                                        width: Get.width / 3 - 45,
                                        height: 2.6,
                                        color:index==selector? AppColor.blueColor:Colors.transparent,
                                      )
                                    ],
                                  ),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: ListView.builder(
                        itemCount: indexState.length,
                        itemBuilder: (context, index) => QuranSoraComponent(
                          indexEntity: indexState[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
