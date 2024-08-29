// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../../../../core/constants/colors.dart';
// import '../../bussniess_logic/quran/index_cubit/index_cubit.dart';
// import '../../bussniess_logic/quran/index_cubit/index_state.dart';
// import '../widgets/quran_sora_component.dart';

// class MoshafIndex extends StatelessWidget {
//   const MoshafIndex({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "الفهرس",
//           style: TextStyle(
//             color: AppColor.blueColor,
//             fontWeight: FontWeight.w400,
//             // fontSize: ,
//             shadows: [
//               Shadow(
//                 color: Colors.black12,
//                 offset: Offset(0, 2),
//                 blurRadius: 6,
//               ),
//             ],
//           ),
//         ),
//         // backgroundColor: AppColor.blueColor.withOpacity(0.9),
//         elevation: 0,
//         // flexibleSpace: Container(
//         //   decoration: BoxDecoration(
//         //     gradient: LinearGradient(
//         //       colors: [AppColor.lightBlue, AppColor.blueColor],
//         //       begin: Alignment.topCenter,
//         //       end: Alignment.bottomCenter,
//         //     ),
//         //   ),
//         // ),
//       ),
//       body: SafeArea(
//         child: BlocBuilder<IndexCubit, IndexState>(
//           builder: (context, state) {
//             final List<dynamic> indexState = state is SurahIndexState
//                 ? SurahIndexState.indexList
//                 : state is ChapterIndexState
//                     ? ChapterIndexState.indexList
//                     : state is HizbIndexState
//                         ? HizbIndexState.indexList
//                         : SurahIndexState.indexList;
//             final int selector = state is SurahIndexState
//                 ? SurahIndexState.selrctor
//                 : state is ChapterIndexState
//                     ? ChapterIndexState.selrctor
//                     : state is HizbIndexState
//                         ? HizbIndexState.selrctor
//                         : SurahIndexState.selrctor;

//             return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.w),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 6),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColor.lightBlue.withOpacity(0.7),
//                           blurRadius: 8,
//                           spreadRadius: 1,
//                         ),
//                          BoxShadow(
//                           color: AppColor.lightBlue.withOpacity(0.7),
//                           blurRadius: 5,
//                           spreadRadius: 1,
//                         ),
                        
//                       ],
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: List.generate(
//                         IndexCubit.moshafIndexTypes.length,
//                         (index) => GestureDetector(
//                           onTap: () {
//                             IndexCubit.get(context).changeSelector(index);
//                           },
//                           child: AnimatedContainer(
//                                  width: Get.width / 3 - 45,
//                             duration: const Duration(milliseconds: 300),
//                             padding: const EdgeInsets.symmetric(vertical: 8),
//                             decoration: BoxDecoration(
//                               color: index == selector
//                                   ? AppColor.lightBlue.withOpacity(0.25)
//                                   : Colors.transparent,
//                               borderRadius: BorderRadius.circular(8),
//                               border: index == selector
//                                   ? Border.all(color: AppColor.blueColor)
//                                   : null,
//                             ),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   IndexCubit.moshafIndexTypes[index],
//                                   style: TextStyle(
//                                     fontSize: 17.sp,
//                                     fontWeight: FontWeight.w500,
//                                     color: AppColor.blueColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 3),
//                                 // Container(
//                                 //   width: Get.width / 3 - 45,
//                                 //   height: 2.6,
//                                 //   color: index == selector
//                                 //       ? AppColor.blueColor
//                                 //       : Colors.transparent,
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: indexState.length,
//                       padding: EdgeInsets.only(bottom: 20.h),
//                       itemBuilder: (context, index) => Padding(
//                         padding: EdgeInsets.symmetric(vertical: 4.h),
//                         child: QuranSoraComponent(
//                           indexEntity: indexState[index],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
