import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../paryer_times/bussniess_logic/date_cubit.dart';

class CompassScreen extends StatelessWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/QuiblahBackGround.PNG',
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 150.h,
                ),
                Text(
                  'اتجاة القبلة',
                  style: TextStyle(
                    fontFamily: 'Thuluth',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
                BlocBuilder<DateCubit, Map<String, String>>(
                  builder: (context, dateState) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: Text(
                            dateState["gregorian"]!,
                            style: const TextStyle(
                                fontFamily: 'Thuluth',
                                color: AppColor.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                wordSpacing: -2),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 50.h,
                ),
                StreamBuilder(
                  stream: FlutterQiblah.qiblahStream,
                  builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    final qiblahDirection = snapshot.data!;

                    return Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            // Compass Image
                            Transform.rotate(
                              angle:
                                  (qiblahDirection.direction * (pi / 180) * -1),
                              child: Image.asset(
                                'assets/images/quiblahCompass.png',
                                width: 250.w, // Adjust size as needed
                                height: 250.h,
                              ),
                            ),
                            // Needle Image
                            Transform.rotate(
                              angle: (qiblahDirection.qiblah * (pi / 180) * -1),
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/neelde.png',
                                width: 120.w, // Adjust size as needed
                                height: 120.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Text(
                          '${qiblahDirection.offset.toInt()}',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                        Text(
                          'الاتجاه التقريبي للقبلة \n في الاباجيه ${qiblahDirection.offset.toInt()}',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColor.blueBlack,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
