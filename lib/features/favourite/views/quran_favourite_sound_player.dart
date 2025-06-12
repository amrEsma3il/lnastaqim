import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../quran_sound_player/logic/surah_player_cubit/surah_player_cubit.dart';
import '../../quran_sound_player/logic/surah_player_cubit/surah_player_state.dart';

// class FavoritesQuranScreen extends StatelessWidget {
//   const FavoritesQuranScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = SurahPlayerCubit.get(context);

//     return BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
//       builder: (context, state) {
//         final favorites = cubit.surahPlayerRepo.favorites;

//         if (favorites.isEmpty) {
//           return const Center(child: Text('لا توجد سور مفضلة'));
//         }

//         return ListView.builder(
//           itemCount: favorites.length,
//           itemBuilder: (context, index) {
//             final favorite = favorites[index];
//             return Dismissible(
//               key: Key(favorite.surahNumber.toString()),
//               background: Container(
//                 color: Colors.red,
//                 alignment: Alignment.centerRight,
//                 padding: const EdgeInsets.only(right: 20),
//                 child: const Icon(Icons.delete, color: Colors.white),
//               ),
//               direction: DismissDirection.endToStart,
//               confirmDismiss: (direction) async {
//                 return await showDialog(
//                   context: context,
//                   builder:
//                       (context) => AlertDialog(
//                         title: const Text("تأكيد"),
//                         content: const Text(
//                           "هل تريد إزالة هذه السورة من المفضلة؟",
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(false),
//                             child: const Text("إلغاء"),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(true),
//                             child: const Text("حذف"),
//                           ),
//                         ],
//                       ),
//                 );
//               },
//               onDismissed: (direction) async {
//                 await cubit.surahPlayerRepo.removeFavorite(
//                   surahNumber: favorite.surahNumber,
//                   reciterId: favorite.reciter.id,
//                 );
//                 // Update state to trigger rebuild
//               },
//               child: ListTile(
//                 title: Text(favorite.surahName),
//                 subtitle: Text(favorite.reciter.nameArabic),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.favorite, color: Colors.red),
//                   onPressed: () async {
//                     await cubit.surahPlayerRepo.removeFavorite(
//                       surahNumber: favorite.surahNumber,
//                       reciterId: favorite.reciter.id,
//                     );
//                     // Update state to trigger rebuild
//                   },
//                 ),
//                 onTap: () {
//                   cubit.changeSurahNum(favorite.surahNumber);
//                   // Find and set the reciter
//                   final reciter = cubit.surahPlayerRepo.reciters.firstWhere(
//                     (r) => r.name == favorite.reciter.name,
//                     orElse: () => cubit.state.reciter,
//                   );
//                   cubit.changeReciter(reciter);
//                   Get.back();
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

