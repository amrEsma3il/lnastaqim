import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/7adis/bussiness_logic/a7adith_cubit.dart';
import 'package:lnastaqim/features/7adis/bussiness_logic/a7adiths_state.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../core/constants/colors.dart';
import 'a7adith_details.dart';
import 'main_a7adith.dart';

class A7adithScreen extends StatelessWidget {
  const A7adithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HadithCubit, HadithState>(
        builder: (context, state) {
          if (state is HadithLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HadithDownloadProgress) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 120.0, // You can adjust the size
                    lineWidth: 10.0, // Thickness of the circular line
                    percent: state.progress,
                    center: Text(
                      '${(state.progress * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 24.0),
                    ),
                    progressColor: AppColor.blueColor, // Change color as needed
                    backgroundColor: Colors.grey[200]!, // Background color
                  ),
                ],
              ),
            );
          } else if (state is HadithLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'فهرس الكتاب ',
                    style: TextStyle(
                        fontFamily: 'Arab140',
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.hadiths[0].metadata!.arabic!.title!,
                    style: const TextStyle(
                        fontFamily: 'Arab140',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: double.infinity,
                          child: SizedBox(
                            height: 50,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (
                                      context,
                                    ) =>
                                            A7adithDetails(
                                              id: index + 1,
                                            )));
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        state.hadiths[0].chapters![index]
                                            .arabic!,
                                        style: const TextStyle(
                                            fontFamily: 'Arab140',
                                            fontSize: 15),
                                        textAlign: TextAlign.right,
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 20,
                        );
                      },
                      itemCount: state.hadiths[0].chapters!.length,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HadithError) {
            return Center(child: Text(state.message));
          } else {
            return const MainHadithScreen();
          }
        },
      ),
    );
  }
}
