// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:equatable/equatable.dart';

// // Models
// class CalendarDate {
//   final DateTime gregorianDate;
//   final int hijriYear;
//   final int hijriMonth;
//   final int hijriDay;

//   CalendarDate({
//     required this.gregorianDate,
//     required this.hijriYear,
//     required this.hijriMonth,
//     required this.hijriDay,
//   });

//   static CalendarDate now() {
//     final now = DateTime.now();
//     final hijriYear = (now.year - 622) * (33/32);
//     final hijriMonth = now.month;
//     final hijriDay = now.day;

//     return CalendarDate(
//       gregorianDate: now,
//       hijriYear: hijriYear.floor(),
//       hijriMonth: hijriMonth,
//       hijriDay: hijriDay,
//     );
//   }

//   String formatGregorianMonth() {
//     return DateFormat.yMMMM('ar').format(gregorianDate);
//   }

//   String formatHijriMonth() {
//     final hijriMonths = [
//       'محرم', 'صفر', 'ربيع الأول', 'ربيع الثاني',
//       'جمادى الأولى', 'جمادى الآخرة', 'رجب', 'شعبان',
//       'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة'
//     ];
//     return '${hijriMonths[hijriMonth - 1]} $hijriYear';
//   }
// }

// // State
// class CalendarState extends Equatable {
//   final CalendarDate selectedDate;
//   final bool isHijri;

//   const CalendarState({
//     required this.selectedDate,
//     required this.isHijri,
//   });

//   factory CalendarState.initial() {
//     return CalendarState(
//       selectedDate: CalendarDate.now(),
//       isHijri: true,
//     );
//   }

//   CalendarState copyWith({
//     CalendarDate? selectedDate,
//     bool? isHijri,
//   }) {
//     return CalendarState(
//       selectedDate: selectedDate ?? this.selectedDate,
//       isHijri: isHijri ?? this.isHijri,
//     );
//   }

//   @override
//   List<Object> get props => [selectedDate, isHijri];
// }

// // Cubit
// class CalendarCubit extends Cubit<CalendarState> {
//   CalendarCubit() : super(CalendarState.initial());

//   void toggleCalendarType() {
//     emit(state.copyWith(isHijri: !state.isHijri));
//   }

//   void nextMonth() {
//     if (state.isHijri) {
//       final currentDate = state.selectedDate;
//       emit(state.copyWith(
//         selectedDate: CalendarDate(
//           gregorianDate: currentDate.gregorianDate,
//           hijriYear: currentDate.hijriMonth == 12 
//               ? currentDate.hijriYear + 1 
//               : currentDate.hijriYear,
//           hijriMonth: currentDate.hijriMonth == 12 
//               ? 1 
//               : currentDate.hijriMonth + 1,
//           hijriDay: currentDate.hijriDay,
//         ),
//       ));
//     } else {
//       final currentDate = state.selectedDate;
//       emit(state.copyWith(
//         selectedDate: CalendarDate(
//           gregorianDate: DateTime(
//             currentDate.gregorianDate.year,
//             currentDate.gregorianDate.month + 1,
//             currentDate.gregorianDate.day,
//           ),
//           hijriYear: currentDate.hijriYear,
//           hijriMonth: currentDate.hijriMonth,
//           hijriDay: currentDate.hijriDay,
//         ),
//       ));
//     }
//   }

//   void previousMonth() {
//     if (state.isHijri) {
//       final currentDate = state.selectedDate;
//       emit(state.copyWith(
//         selectedDate: CalendarDate(
//           gregorianDate: currentDate.gregorianDate,
//           hijriYear: currentDate.hijriMonth == 1 
//               ? currentDate.hijriYear - 1 
//               : currentDate.hijriYear,
//           hijriMonth: currentDate.hijriMonth == 1 
//               ? 12 
//               : currentDate.hijriMonth - 1,
//           hijriDay: currentDate.hijriDay,
//         ),
//       ));
//     } else {
//       final currentDate = state.selectedDate;
//       emit(state.copyWith(
//         selectedDate: CalendarDate(
//           gregorianDate: DateTime(
//             currentDate.gregorianDate.year,
//             currentDate.gregorianDate.month - 1,
//             currentDate.gregorianDate.day,
//           ),
//           hijriYear: currentDate.hijriYear,
//           hijriMonth: currentDate.hijriMonth,
//           hijriDay: currentDate.hijriDay,
//         ),
//       ));
//     }
//   }
// }

// // Main Screen Widget
// class CalendarView extends StatelessWidget {
//   const CalendarView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => CalendarCubit(),
//       child: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             color: Color(0xFFF5F5F5),
//           ),
//           child: Column(
//             children: const [
//               _CalendarHeader(title: 'التقويم'),
//               _CalendarTypeSelector(),
//               Expanded(child: _CalendarGrid()),
//               _CalendarFooter(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Header Widget
// class _CalendarHeader extends StatelessWidget {
//   final String title;

//   const _CalendarHeader({
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         color: Color(0xFF693D1D),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Icon(Icons.chevron_right, color: Colors.white),
//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Icon(Icons.chevron_left, color: Colors.white),
//         ],
//       ),
//     );
//   }
// }

// // Type Selector Widget
// class _CalendarTypeSelector extends StatelessWidget {
//   const _CalendarTypeSelector();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CalendarCubit, CalendarState>(
//       builder: (context, state) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildTypeButton(
//                 'التقويم الميلادي',
//                 !state.isHijri,
//                 () => context.read<CalendarCubit>().toggleCalendarType(),
//                 context,
//               ),
//               const SizedBox(width: 16),
//               _buildTypeButton(
//                 'التقويم الهجري',
//                 state.isHijri,
//                 () => context.read<CalendarCubit>().toggleCalendarType(),
//                 context,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildTypeButton(String text, bool isSelected, VoidCallback onTap, BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF693D1D) : Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Calendar Grid Widget
// class _CalendarGrid extends StatelessWidget {
//   const _CalendarGrid();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CalendarCubit, CalendarState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             _buildMonthHeader(context, state),
//             _buildWeekDays(),
//             _buildCalendarDays(state),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildMonthHeader(BuildContext context, CalendarState state) {
//     final monthText = state.isHijri
//         ? state.selectedDate.formatHijriMonth()
//         : state.selectedDate.formatGregorianMonth();

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.chevron_left),
//             onPressed: () => context.read<CalendarCubit>().previousMonth(),
//           ),
//           Text(
//             monthText,
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.chevron_right),
//             onPressed: () => context.read<CalendarCubit>().nextMonth(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWeekDays() {
//     final weekDays = ['سبت', 'أحد', 'اثن', 'ثلاث', 'اربع', 'خميس', 'جمعة'];
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: weekDays
//           .map((day) => Text(
//                 day,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.brown,
//                 ),
//               ))
//           .toList(),
//     );
//   }

//   Widget _buildCalendarDays(CalendarState state) {
//     final currentDay = state.isHijri
//         ? state.selectedDate.hijriDay
//         : state.selectedDate.gregorianDate.day;

//     return Expanded(
//       child: GridView.builder(
//         padding: const EdgeInsets.all(8),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 7,
//           mainAxisSpacing: 8,
//           crossAxisSpacing: 8,
//         ),
//         itemCount: 30,
//         itemBuilder: (context, index) {
//           final day = index + 1;
//           final isCurrentDay = day == currentDay;

//           return Container(
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: isCurrentDay ? const Color(0xFF693D1D) : Colors.white,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               '$day',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: isCurrentDay ? Colors.white : Colors.black,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // Footer Widget
// class _CalendarFooter extends StatelessWidget {
//   const _CalendarFooter();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.favorite, color: Colors.red),
//           const SizedBox(width: 8),
//           Text(
//             'ما تصلي على النبي بينا لك هنا',
//             style: TextStyle(
//               color: Colors.brown[700],
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }