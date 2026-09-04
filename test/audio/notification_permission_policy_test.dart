import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/core/utilits/services/local_notification_service.dart';

void main() {
  test('notification denial does not block application startup', () async {
    Object? reportedError;

    final granted = await requestNotificationPermissionWithoutBlocking(
      request: () async => throw StateError('denied'),
      onError: (error) => reportedError = error,
    );

    expect(granted, isFalse);
    expect(reportedError, isA<StateError>());
  });

  test('successful notification permission is reported', () async {
    final granted = await requestNotificationPermissionWithoutBlocking(
      request: () async {},
    );

    expect(granted, isTrue);
  });
}
