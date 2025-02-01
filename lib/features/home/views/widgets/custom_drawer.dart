import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/home/views/widgets/custom_drawer_item__list_view.dart';

import '../../../../core/constants/images.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.7,
        color: AppColor.white,
        child: Column(
          children: [
          Container(
  decoration: const BoxDecoration(
    color: Color(0xff112351), // لون خلفي في حال عدم تحميل الصورة
    image: DecorationImage(opacity: 0.1,
    filterQuality: FilterQuality.none,
      image: AssetImage(AppImages.homeBackground), // صورة من assets
      fit: BoxFit.cover, // لضبط الصورة لتملأ الحاوية بالكامل
    ),
  ),
  child: Column(
    children: [
      GestureDetector(
        onTap: () {
          scaffoldKey.currentState!.closeEndDrawer();
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ),
      const SizedBox(height: 100),
    ],
  ),
)
,
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: CustomDrawerItemListView(
              scaffoldKey: scaffoldKey,
            )),
          ],
        ),
      ),
    );
  }
}
