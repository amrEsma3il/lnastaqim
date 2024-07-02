import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';

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
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.amber,
                  ),
                ),
                Text(
                  ' الجمعة , ٢٥ اغسطس',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkBrown,
                  ),
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
                          children: <Widget>[
                            Transform.rotate(
                              angle:
                                  (qiblahDirection.direction * (pi / 180) * -1),
                              child: Image.asset(
                                  'assets/images/quiblahCompass.png'),
                            ),
                            Positioned(
                              right: 80,
                              top: 60,
                              child: Transform.rotate(
                                angle:
                                    (qiblahDirection.qiblah * (pi / 180) * -1),
                                alignment: Alignment.center,
                                child: Image.asset('assets/images/neelde.png'),
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
                            color: AppColor.darkBrown,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Text(
                  'الاتجاه التقريبي للقبلة \n في الاباجيه 136',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColor.amber,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
