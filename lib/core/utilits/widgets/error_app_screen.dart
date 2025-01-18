// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// import '../../../main.dart';

// class ErrorApp extends StatelessWidget {
//   final String errorMessage;

//   const ErrorApp({
//     Key? key,
//     required this.errorMessage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('خطأ')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 errorMessage,
//                 style: const TextStyle(color: Colors.red, fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   // محاولة إعادة تشغيل التطبيق بعد طلب الإذن
//                   try {
//                     await determinePosition();
//                     runApp(const Lnastaqim());
//                   } catch (e) {
//                     // البقاء في شاشة الخطأ إذا فشل
//                   }
//                 },
//                 child: const Text('المحاولة مجددًا'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
