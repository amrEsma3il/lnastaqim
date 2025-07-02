import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../bussniess_logic/quran/index_cubit/index_cubit.dart';
import '../../bussniess_logic/quran/quran_cubit.dart';
import '../widgets/index/quran_juz_component.dart';
import '../widgets/index/quran_sora_component.dart';

class MoshafIndex extends StatefulWidget {
  const MoshafIndex({super.key});

  @override
  State<MoshafIndex> createState() => _MoshafIndexState();
}

class _MoshafIndexState extends State<MoshafIndex> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = AppColor.primary.withValues(alpha:  0.91);
    return Scaffold(
    
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'فهرس المصحف',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: bgColor,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            children: [
              SearchFieldWidget(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val.trim()),
              ),
              SizedBox(height: 18.h),
              TabSelectorWidget(
                selectedIndex: _selectedIndex,
                onTabChanged: (index) => setState(() => _selectedIndex = index),
              ),
              Divider(
                color: Colors.white.withOpacity(0.2),
                thickness: 0.8,
                height: 24.h,
                indent: 10.w,
                endIndent: 10.w,
              ),
              Expanded(
                child: _selectedIndex == 0
                    ? TabContentWidget(index: 0, searchQuery: _searchQuery)
                    : TabContentWidget(index: 1, searchQuery: _searchQuery),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchFieldWidget({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'ابحث عن سورة أو جزء...',
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        ),
      ),
    );
  }
}

class TabSelectorWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  const TabSelectorWidget({super.key, required this.selectedIndex, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: List.generate(2, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(index),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  index == 0 ? "السور" : "الأجزاء",
                  style: TextStyle(
                    color: isSelected ? AppColor.primary : Colors.white,
                    fontSize: 16.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class TabContentWidget extends StatelessWidget {
  final int index;
  final String searchQuery;
  const TabContentWidget({super.key, required this.index, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      final filtered = IndexCubit.getQuranSurah()
          .where((s) =>
              s.name.contains(searchQuery) ||
              s.id.toString().contains(searchQuery))
          .toList();

      return ListView.builder(
        padding: EdgeInsets.only(top: 10.h),
        itemCount: filtered.length,
        itemBuilder: (_, index) => QuranSoraComponent(
          isFromDialog: false,
          indexEntity: filtered[index],
        ),
      );
    } else {
      final filtered = IndexCubit.getQuranJuz()
          .where((juz) =>
              IndexCubit.juzArabicWord(juz.juz).contains(searchQuery) ||
              juz.juz.toString().contains(searchQuery))
          .toList();

      return ListView.builder(
        padding: EdgeInsets.only(top: 10.h),
        itemCount: filtered.length,
        itemBuilder: (_, index) => JuzComponent(
          isFromDialog: false,
          parentIndex: index,
        ),
      );
    }
  }
}
