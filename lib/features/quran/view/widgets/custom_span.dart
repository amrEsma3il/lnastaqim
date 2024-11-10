import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/utilits/extensions/color_from_hex.dart';

// typedef GestureTapCallback = void Function();
typedef LongPressStartDetailsFunction = void Function(LongPressStartDetails)?;

TextSpan span({
  Color? textColor,
  required Color backgroundColor,
  required String text,
  required int pageIndex,
  double? fontSize,
  required int surahNum,
  required int ayahNum,
  // GestureTapCallback? onTap,
  LongPressStartDetailsFunction? onLongPressStart,
  required bool isFirstAyah,
  // required bool useLongPress, // New parameter to switch between tap and long press
}) {
  if (text.isNotEmpty) {
    final String partOne = text.length < 3 ? text[0] : text[0] + text[1];
    final String? partTwo = text.length > 2 ? text.substring(2, text.length - 1) : null;
    final String initialPart = text.substring(0, text.length - 1);
    final String lastCharacter = text.substring(text.length - 1);

    // Helper function to create the recognizer based on `useLongPress`
    GestureRecognizer? createRecognizer() {
      // if (useLongPress) {
        return LongPressGestureRecognizer(duration: const Duration(milliseconds: 500))
          ..onLongPressStart = onLongPressStart;
      // } else {
      //   return TapGestureRecognizer()..onTap = onTap;
      // }
    }

    TextSpan? first;
    TextSpan? second;

    if (isFirstAyah) {
      first = TextSpan(
        text: partOne,
        style: TextStyle(
          fontFamily: 'page${pageIndex + 1}',
          fontSize: fontSize,
          letterSpacing: 30,
          color: textColor,
          backgroundColor: backgroundColor,
        ),
        recognizer: createRecognizer(),
      );

      second = TextSpan(
        text: partTwo,
        style: TextStyle(
          fontFamily: 'page${pageIndex + 1}',
          fontSize: fontSize,
          letterSpacing: 5,
          color:textColor,
          backgroundColor: backgroundColor,
        ),
        recognizer: createRecognizer(),
      );
    }

    final TextSpan initialTextSpan = TextSpan(
      text: initialPart,
      style: TextStyle(
        fontFamily: 'page${pageIndex + 1}',
        fontSize: fontSize,
        letterSpacing: 5,
        color:textColor,
        backgroundColor: backgroundColor,
      ),
      recognizer: createRecognizer(),
    );

    final TextSpan lastCharacterSpan = TextSpan(
      text: lastCharacter,
      style: TextStyle(
        shadows: [
          Shadow(color: "#404c6e".toColor, offset: Offset(1.3.w, 1.3.h), blurRadius: 1.3.r),
          Shadow(color: "#404c6e".toColor, offset: Offset(1.3.w, 1.3.h), blurRadius: 1.3.r),
          Shadow(color: "#404c6e".toColor, offset: Offset(1.3.w, 1.3.h), blurRadius: 1.3.r),
          Shadow(color: "#404c6e".toColor, offset: Offset(1.3.w, 1.3.h), blurRadius: 1.3.r),
        ],
        fontFamily: 'page${pageIndex + 1}',
        fontSize: fontSize,
        letterSpacing: 5,
        color: "#404c6e".toColor,
        backgroundColor: backgroundColor,
      ),
      recognizer: createRecognizer(),
    );

    return TextSpan(
      children: isFirstAyah
          ? [first!, second!, lastCharacterSpan]
          : [initialTextSpan, lastCharacterSpan],
    );
  } else {
    return const TextSpan(text: '');
  }
}
