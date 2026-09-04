import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/features/ibtihal/view/screens/ibtihalat_player_screen.dart';

void main() {
  testWidgets('fractional tail overrun is clamped before reaching Slider', (
    tester,
  ) async {
    const position = 46.236;
    const duration = 46.215;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Slider(
            value: safeIbtihalSliderValue(position, duration),
            max: safeIbtihalSliderMaximum(duration),
            onChanged: (_) {},
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(tester.widget<Slider>(find.byType(Slider)).value, duration);
  });
}
