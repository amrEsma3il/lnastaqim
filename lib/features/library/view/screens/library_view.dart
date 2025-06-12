import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';


class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "المكتبة",
        isLayout: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEEF2F7), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.menu_book_rounded,
                    size: 67,
                    color: Color(0xFF37517E),
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  'قريبًا',
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                    color: Color(0xFF37517E),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                   'نعمل حاليًا على تطوير قسم المكتبة\nليكون مرجعك الشامل لكل ما يفيدك.\nترقّب إطلاقه قريبًا بإذن الله.',

                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.7,
                   
                    color: Colors.black87,
                  ),
                ),

                // const SizedBox(height: 20),

                // عداد (Placeholder حاليًا)
                // CountdownTimer(targetDate: DateTime(2025, 7, 1)),

                const SizedBox(height: 26),

                const Text(
                  '▬▬▬▬ ❖ ▬▬▬▬',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF37517E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

