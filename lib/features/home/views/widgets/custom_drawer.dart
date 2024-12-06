import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/home/views/widgets/custom_drawer_item__list_view.dart';

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
              color: const Color(0xff112351),
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
                            ))),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
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
