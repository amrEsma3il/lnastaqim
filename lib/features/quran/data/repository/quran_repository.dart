import 'package:flutter/material.dart';

import '../data_sources/const_data_sources/quran_const_data_sources.dart';
import '../models/quran_model.dart';


class QuranRepository {
  static List<SoraModel> getAllQuranSowar() =>QuranConstDataSources.getAllQuranSowar();
      



  // static SoraModel getSoraDetails( SoraModel quaranJson) =>QuranConstDataSources.getSoraDetails(quaranJson);
   
}




   showPageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          title: const Text(
            'انتقال سريع',
            textAlign: TextAlign.right,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'أدخل رقم الصفحة',
                textAlign: TextAlign.right,
              ),
              TextField(
                controller: TextEditingController(),
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '١',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'انتقال سريع',
                textAlign: TextAlign.right,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '١. الفاتحة',
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '١',
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('موافق'),
            ),
          ],
        );
      },
    );
  }

