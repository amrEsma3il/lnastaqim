import 'package:flutter/material.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/custom_menu.dart';

import '../widget/books_grid_view.dart';

class MainHadithScreen extends StatelessWidget {
  const MainHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomMenu(
          isZekr: false,
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BooksGridView(),
        ],
      ),
    );
  }
}
