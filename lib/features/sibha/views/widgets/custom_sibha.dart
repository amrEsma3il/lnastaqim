import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class CustomSibha extends StatefulWidget {
  const CustomSibha({Key? key}) : super(key: key);

  @override
  State<CustomSibha> createState() => _CustomSibhaState();
}

class _CustomSibhaState extends State<CustomSibha>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
  bool _isSpinning = false;
  int _count = 0;

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }

  void _resetCount() {
    setState(() {
      _count = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _animationController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
  }

  void _startSpinning() {
    setState(() {
      _isSpinning = true;
    });
    _animationController.repeat();
  }

  void _stopSpinning() {
    setState(() {
      _isSpinning = false;
    });
    _animationController.stop();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _stopSpinning();
    } else if (state == AppLifecycleState.resumed && _isSpinning) {
      _startSpinning();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isSpinning) {
          _startSpinning();
          _incrementCount();
          Future.delayed(const Duration(seconds: 1), () {
            _stopSpinning();
          });
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: 110,
                child: Container(
                  height: 130.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.darkBrown.withOpacity(0.29),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff000000).withOpacity(0.25),
                            blurRadius: 4.r,
                            blurStyle: BlurStyle.outer,
                            spreadRadius: BorderSide.strokeAlignCenter)
                      ]),
                  child: Center(
                    child: Text(
                      _count.toString(),
                      style: TextStyle(
                        color: AppColor.darkBrown,
                        fontSize: 53.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 3,
                    child: Transform.rotate(
                      alignment: Alignment.center,
                      angle:
                          _animationController.value * 2.5 * 3.141592653589793,
                      child: Image.asset(
                        'assets/images/sibha.png', // Replace with your image asset path
                        width: 350.w,
                        height: 250.h,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          _resetCount();
                          _animationController.value = 0;
                        },
                        icon: Icon(
                          Icons.refresh,
                          size: 45.h,
                          color: AppColor.darkBrown,
                        )),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
