abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class SaveNotificationState extends NotificationState {
  final bool isSalahNabiNotification;
  final bool isAzkarNotification;

  SaveNotificationState({
    required this.isSalahNabiNotification,
    required this.isAzkarNotification,
  });
}

class ChangeSalahNabiNotification extends NotificationState {}

class ChangeAzkarNotification extends NotificationState {}

class ChangeNotificationTime extends NotificationState {}
