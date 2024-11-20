import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/home/views/widgets/custom_drawer_item__list_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.7,
          color: AppColor.primary,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  scaffoldKey.currentState!.closeEndDrawer();
                },
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.close,
                          color: AppColor.white,
                        ))),
              ),
              const SizedBox(
                height: 78,
              ),
              Expanded(
                  child: CustomDrawerItemListView(
                scaffoldKey: scaffoldKey,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
