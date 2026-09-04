import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/core/utilits/extensions/color_from_hex.dart';
import 'package:lnastaqim/features/quran_sound_player/view/widgets/surah_slider_widget.dart';

void main() {
  group('Core Utilities & Constants Tests', () {
    test('HexColor extension correctly converts hex strings to Color', () {
      final colorWithHash = '#FAF6EB'.toColor;
      final colorWithoutHash = 'FAF6EB'.toColor;

      expect(colorWithHash, equals(const Color(0xFFFAF6EB)));
      expect(colorWithoutHash, equals(const Color(0xFFFAF6EB)));
    });

    test('AppColor constants are properly initialized', () {
      expect(AppColor.lightGrey, equals(const Color(0xffD9D9D9)));
      expect(AppColor.teal, equals(const Color(0xff25827a)));
    });

    testWidgets('Basic MaterialApp smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Text('Lnastaqim App'))),
      );

      expect(find.text('Lnastaqim App'), findsOneWidget);
    });

    testWidgets('Surah slider safely clamps a tail position above duration', (
      WidgetTester tester,
    ) async {
      const duration = 46.215;
      const finalPositionTick = 46.236;
      final value = safeSurahSliderValue(finalPositionTick, duration);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Slider(value: value, max: duration, onChanged: (_) {}),
          ),
        ),
      );

      expect(tester.widget<Slider>(find.byType(Slider)).value, duration);
      expect(tester.takeException(), isNull);
    });
  });
}
