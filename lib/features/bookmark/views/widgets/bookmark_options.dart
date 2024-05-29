// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lnastaqim/features/bookmark/views/widgets/custom_button.dart';
//
// void showBookmarkBottomSheetOptions(BuildContext context, bookmark) {
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.grey.shade400,
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topRight: Radius.circular(48.r), topLeft: Radius.circular(48.r))),
//     builder: (context) => SizedBox(
//       height: 400.h,
//       width: double.infinity,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   CustomButton(
//                       backgroundColor: Colors.red,
//                       buttonName: "Delete Bookmark",
//                       onTap: () {
//                         bookmark.delete();
//                       }),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
