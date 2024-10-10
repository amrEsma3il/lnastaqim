import 'package:flutter/material.dart';

import '../widget/books_grid_view.dart';

class MainHadithScreen extends StatelessWidget {
  const MainHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            BooksGridView(),
          ],
        ),
      ),
    );
  }
}
