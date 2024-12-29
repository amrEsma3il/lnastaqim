import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/Competitions/view/screens/competitions_view.dart';
import 'package:lnastaqim/features/calender/view/screens/calender_view.dart';
import 'package:lnastaqim/features/community/view/screens/community_view.dart';
import 'package:lnastaqim/features/home/views/screens/home_view.dart';
import 'package:lnastaqim/features/layout/presentation/widgets/custom_bottom_nav_bar_item.dart';
import 'package:lnastaqim/features/library/view/screens/library_view.dart';

import '../../../quran/bussniess_logic/font_cubit/font_loader_test.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {


@override
  void initState() {


    super.initState();
  }

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const LibraryView(),
    const CalenderView(),
    const CommunityView(),
    const CompetitionsView()
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }



  void _onNavBarItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {


    
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 33, top: 15),
        decoration: BoxDecoration(
          color: AppColor.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomBottomNavigationBarItem(
              pageController: _pageController,
              icon: Icons.psychology_outlined,
              index: 4,
              isSelected: _currentIndex == 4,
              onTap: _onNavBarItemTapped,
            ),
            CustomBottomNavigationBarItem(
              pageController: _pageController,
              icon: Icons.groups_2,
              index: 3,
              isSelected: _currentIndex == 3,
              onTap: _onNavBarItemTapped,
            ),
            CustomBottomNavigationBarItem(
              pageController: _pageController,
              icon: Icons.calendar_month,
              index: 2,
              isSelected: _currentIndex == 2,
              onTap: _onNavBarItemTapped,
            ),
            CustomBottomNavigationBarItem(
              pageController: _pageController,
              icon: Icons.local_library_outlined,
              index: 1,
              isSelected: _currentIndex == 1,
              onTap: _onNavBarItemTapped,
            ),
            CustomBottomNavigationBarItem(
              pageController: _pageController,
              icon: Icons.home,
              index: 0,
              isSelected: _currentIndex == 0,
              onTap: _onNavBarItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}
