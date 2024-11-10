import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../bussiness_logic/a7adith_cubit.dart';
import '../../data/model/book_model.dart';
import '../screen/a7adith_screen.dart';
import 'book_item.dart';

class BooksGridView extends StatelessWidget {
  const BooksGridView({super.key});

  @override
  Widget build(BuildContext context) {
    List<BooksModel> books = [
      BooksModel(
          id: 1,
          name: 'صحيح البخاري',
          color: AppColor.teal,
          image: AppImages.bukariImage,
          onTap: () {
            context.read<HadithCubit>().bukhariHadithsCubit(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const A7adithScreen()));
          }),
      BooksModel(
          id: 2,
          name: 'صحيح مسلم',
          color: AppColor.steelblue,
          image: AppImages.muslimImage,
          onTap: () {
            context.read<HadithCubit>().muslimHadithsCubit(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const A7adithScreen()));
          }),
      BooksModel(
        id: 3,
        name: 'سنن ابي \n داود',
        color: AppColor.slategray,
        image: AppImages.abidawoodImage,
        onTap: () {
          context.read<HadithCubit>().abuDawudHadithsCubit(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const A7adithScreen()));
        },
      ),
      BooksModel(
        id: 4,
        name: 'جامع الترمذي',
        color: AppColor.duskyrose,
        image: AppImages.tarmziImage,
        onTap: () {
          context.read<HadithCubit>().tirmidhiHadithsCubit(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const A7adithScreen()));
        },
      ),
      BooksModel(
        id: 5,
        name: 'سنن النسائي',
        color: AppColor.charcoalgray,
        image: AppImages.neasaiImage,
        onTap: () {
          context.read<HadithCubit>().nasaiHadithsCubit(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const A7adithScreen()));
        },
      ),
      BooksModel(
          id: 6,
          name: 'سنن ابن ماجه',
          color: AppColor.mutedmauve,
          image: AppImages.ebnmagaImage,
          onTap: () {
            context.read<HadithCubit>().ibnmajahHadithsCubit(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const A7adithScreen()));
          }),
      BooksModel(
          id: 7,
          name: 'موطا مالک',
          color: AppColor.forestgreen,
          image: AppImages.motamalekImage,
          onTap: () {
            context.read<HadithCubit>().malikHadithsCubit(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const A7adithScreen()));
          }),
      BooksModel(
          id: 8,
          name: 'مسند الدارمي',
          color: AppColor.warmcopper,
          image: AppImages.masneddramiImage,
          onTap: () {
            context.read<HadithCubit>().darimiHadithsCubit(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const A7adithScreen()));
          }),
      BooksModel(
          id: 9,
          name: 'مسند أحمد',
          color: AppColor.brickred,
          image: AppImages.masnedahmedImage,
          onTap: () {
            context.read<HadithCubit>().ahmedHadithsCubit(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const A7adithScreen()));
          }),
    ];

    return GridView.count(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        childAspectRatio: 1 / 1.3,
        children: List.generate(
          books.length,
          (item) => GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BookItem(
                  booksModel: books[item],
                ),
              )),
        ));
  }
}
