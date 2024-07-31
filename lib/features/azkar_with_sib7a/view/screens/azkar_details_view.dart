import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/azkar_details_items_list_view.dart';

import '../../../../core/constants/colors.dart';
import '../../business_logic/azkar_details_cubit/azkar_details_cubit.dart';
import '../widgets/custom_azkar_details_appbar.dart';

class AzkarDetailsView extends StatelessWidget {
  const AzkarDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments as String;

    return Scaffold(
      backgroundColor: AppColor.creame,
      body: SafeArea(
        child: BlocBuilder<AzkarDetailsCubit, List<AzkarModel>>(
          builder: (context, state) {
            return Column(
              children: [
                CustomAzkarDetailsAppBar(category: category),
                const Divider(
                  height: 0,
                ),
                SizedBox(
                  height: 26.h,
                ),
                Expanded(
                  child: AzkarDetailsItemsListView(
                    category: category,
                    items: state,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
