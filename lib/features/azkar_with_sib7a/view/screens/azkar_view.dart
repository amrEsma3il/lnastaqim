import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/bussniess_logic/azkar_cubit/azkar_cubit.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';

import '../../../../core/constants/colors.dart';
import '../widgets/category_list_view.dart';

class AzkarView extends StatelessWidget {
  const AzkarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AzkarCubit, List<AzkarModel>>(
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.azkarBackground),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(AppImages.azkarHeader),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 41,
                      decoration: ShapeDecoration(
                          color: AppColor.darkBrown,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(
                              "الاذكار",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_drop_up,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(child: AzkarCategoryListView(items: state)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
