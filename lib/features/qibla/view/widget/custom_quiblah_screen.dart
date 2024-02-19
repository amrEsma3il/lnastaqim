import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomQuiblahScreen extends StatelessWidget {
  const CustomQuiblahScreen({super.key});

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
          Column(
            children: [
              SizedBox(
                height: 150.h,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'اتجاة القبلة',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  ' الجمعة , ٢٥ اغسطس',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 122, 101, 41),
                  ),
                ),
              ),
            ],
          ),
        
        ],
      ),
    );
  }
}
