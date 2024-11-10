import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../bussiness_logic/a7adith_cubit.dart';
import '../../bussiness_logic/a7adiths_state.dart';
import '../../data/model/a7adith_model.dart';

class A7adithDetails extends StatelessWidget {
  const A7adithDetails({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HadithCubit, HadithState>(
      builder: (context, state) {
        if (state is HadithLoaded) {
          List<Hadiths> filteredHadiths = state.hadiths[0].hadiths!
              .where((hadith) => hadith.chapterId == id)
              .toList();

          return Scaffold(
            body: SafeArea(
              child: ListView.separated(
                itemCount: filteredHadiths.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColor.primary.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              '  ${state.hadiths[0].metadata!.arabic!.title}  |  ${state.hadiths[0].chapters![id - 1].arabic}  ',
                              style: const TextStyle(
                                  fontFamily: 'Authmanic',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          filteredHadiths[index].arabic ?? 'No text available',
                          style:
                              const TextStyle(fontSize: 18, wordSpacing: -0.9),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 5,
                  );
                },
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
              child:
                  CircularProgressIndicator()), // Show a loading spinner while data is loading
        );
      },
    );
  }
}
