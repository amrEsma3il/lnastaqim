import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';

// import '../../../../core/constants/images.dart';

class SurahInfoWidget extends StatelessWidget {
  const SurahInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: Get.width,height: 515,
      decoration: BoxDecoration( 
          borderRadius: BorderRadius.circular(35),
        image: DecorationImage(alignment: Alignment.center,
                    image:  const AssetImage('assets/images/reciter_10.png'),
                    fit: BoxFit.cover,
                    opacity: 0.9,
                    colorFilter: ColorFilter.mode(
                    AppColor.blueColor.withOpacity(0.9),
                      BlendMode.modulate,
                    ),
                  ),),
      child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 215,height: 215,
         decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(400),
          image: DecorationImage(alignment: Alignment.center,
                    image:  const AssetImage('assets/images/reciter_10.png'),
                    fit: BoxFit.cover,
opacity: 0.9,
                    colorFilter: ColorFilter.mode(
                    AppColor.blueColor.withOpacity(0.65),
                      BlendMode.darken,
                    ),
                  ),),
          ),
          const SizedBox(height: 20),
           Text(
            "القارئ ياسين",
            style: TextStyle(fontSize: 23,color: AppColor.lightBlue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
