import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constants/animations.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../bussniess_logic/radio_cubit.dart';
import '../../bussniess_logic/radio_state.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RadioCubit(),
      child: BlocConsumer<RadioCubit, RadioState>(
        listener: (context, state) {
          if(state.audioState is AudioFetchFailure){
showToast("توجد مشكلة اثناء تشغيل الملف الصوتي",AppColor.blueTint2);
          }
        },
        builder: (context, state) {
          final cubit = context.read<RadioCubit>();
          final channel = cubit.currentChannel;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.blueTint2,
              toolbarHeight: 80.h,
              title: Text(
                "الاذاعة",
                style: TextStyle(
                  fontSize: 27.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  // شريط التنقل السفلي
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        toggleRadioBar.length,
                        (index) => _buildNavItem(
                          context: context,
                          label: toggleRadioBar[index]['label'],
                          icon: toggleRadioBar[index]['icon'],
                          isSelected: index == state.radioCatIndex,
                          onTap: () => cubit.changeRadioCat(index),
                        ),
                      ),
                    ),
                  ),
                  // محتوى الشاشة
                  Expanded(
                    child: channel == null
                        ? const Center(child: Text('لا توجد قنوات متاحة'))
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      width: 250,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color: AppColor.blueTint2,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          AppImages.microphone,
                                          width: 125.w,
                                          height: 125.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    channel.title!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    channel.description!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      color: AppColor.gray,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  // عناصر التحكم
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildControlButton(
                                        icon: Icons.skip_next,
                                        onTap: () => cubit.previous(),
                                      ),
                                      SizedBox(width: 16.w),
                                      CircleAvatar(
                                        radius: 27,
                                        backgroundColor: AppColor.lightBlue,
                                        child: state.audioState is AudioFetchLoading
                                            ? Lottie.asset(
         AppAnimation.typeLoading, // مسار ملف Lottie الخاص بك
          width: 34.w, // حجم الرسوم المتحركة
          height: 45.h,
          fit: BoxFit.contain,
          repeat: true,
          animate: true,

        )
                                            : IconButton(
                                                color: AppColor.blueColor,
                                                icon: state.isPlaying
                                                    ? const Icon(Icons.pause_circle_outline)
                                                    : const Icon(Icons.play_arrow_outlined),
                                                onPressed: () {
                                                  cubit.playOrPause();
                                                },
                                              ),
                                      ),
                                      SizedBox(width: 16.w),
                                      _buildControlButton(

                                        icon: Icons.skip_previous,
                                        onTap: () => cubit.next(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  // زر عرض القنوات
                                  ElevatedButton(
                                    onPressed: () {
                                      _showChannelList(context, cubit,state);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.blueTint2,
                                    ),
                                    child: Text(
                                      "عرض القنوات",
                                      style: TextStyle(fontSize: 18.sp,color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : AppColor.gray,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }


  

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 0.9, color: AppColor.blueTint2),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColor.blueTint2),
        onPressed: onTap,
      ),
    );
  }

  void _showChannelList(BuildContext context, RadioCubit cubit,RadioState state) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
              itemCount: cubit.categories[state.radioCatIndex]!.length,
              itemBuilder: (context, index) {
                final channel = cubit.categories[state.radioCatIndex]![index];
                return ListTile(
                  leading:  Icon(Icons.radio,color: AppColor.blueTint2,),
                  title: Text(channel.title!),
                  onTap: () {
                    cubit.playOrPause(selectesChannel: channel,currentIndex: index);
                    Navigator.pop(context);
                  },
                );
              },
            );
      },
    );
  }
}

List<Map<String, dynamic>> toggleRadioBar = [
  {"label": "القرآن", "icon": Icons.radio},
  {"label": "القراء", "icon": Icons.person},
  {"label": "أخرى", "icon": Icons.more_horiz},
];