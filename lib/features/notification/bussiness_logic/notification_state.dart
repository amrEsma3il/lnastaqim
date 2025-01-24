import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  final bool fajarAlarmStatus;
  final bool duharAlarmStatus;
  final bool asrAlarmStatus;
  final bool maghribAlarmStatus;
  final bool ishaAlarmStatus;
  final bool salahNabiNotificationStatus;
  final bool morningAndEviningNotificationStatus;

  final String fajarAlarmSound;
  final String duharAlarmSound;
  final String asrAlarmSound;
  final String maghribAlarmSound;
  final String ishaAlarmSound;
  final String salahNabiNotificationSound;

  final int salahNabiNotificationFrequancy;
  final int morningAndEviningNotificationFrequancy;


  const NotificationState({
    required this.fajarAlarmStatus,
    required this.duharAlarmStatus,
    required this.asrAlarmStatus,
    required this.maghribAlarmStatus,
    required this.ishaAlarmStatus,
    required this.salahNabiNotificationStatus,
    required this.morningAndEviningNotificationStatus,
    required this.fajarAlarmSound,
    required this.duharAlarmSound,
    required this.asrAlarmSound,
    required this.maghribAlarmSound,
    required this.ishaAlarmSound,
    required this.salahNabiNotificationSound,
    required this.salahNabiNotificationFrequancy,
    required this.morningAndEviningNotificationFrequancy,
  });

  factory NotificationState.init() => const NotificationState(
        fajarAlarmStatus: false,
        duharAlarmStatus: false,
        asrAlarmStatus: false,
        maghribAlarmStatus: false,
        ishaAlarmStatus: false,
        salahNabiNotificationStatus: false,
        morningAndEviningNotificationStatus: false,
        fajarAlarmSound: "احمد الطرابلسي",
        duharAlarmSound: "علي بن احمد الملا",
        asrAlarmSound: "علي بن احمد الملا",
        maghribAlarmSound: "علي بن احمد الملا",
        ishaAlarmSound: "علي بن احمد الملا",
        salahNabiNotificationSound: 'صلي علي محمد',
        salahNabiNotificationFrequancy: 15,
        morningAndEviningNotificationFrequancy: 15,
      );

  @override
  List<Object> get props => [
        fajarAlarmStatus,
        duharAlarmStatus,
        asrAlarmStatus,
        maghribAlarmStatus,
        ishaAlarmStatus,
        salahNabiNotificationStatus,
        morningAndEviningNotificationStatus,
        fajarAlarmSound,
        duharAlarmSound,
        asrAlarmSound,
        maghribAlarmSound,
        ishaAlarmSound,
        salahNabiNotificationSound,
        salahNabiNotificationFrequancy,
        morningAndEviningNotificationFrequancy,
      ];

  NotificationState copyWith({
    bool? fajarAlarmStatus,
    bool? duharAlarmStatus,
    bool? asrAlarmStatus,
    bool? maghribAlarmStatus,
    bool? ishaAlarmStatus,
    bool? salahNabiNotificationStatus,
    bool? morningAndEviningNotificationStatus,
    String? fajarAlarmSound,
    String? duharAlarmSound,
    String? asrAlarmSound,
    String? maghribAlarmSound,
    String? ishaAlarmSound,
    String? salahNabiNotificationSound,
    int? salahNabiNotificationFrequancy,
    int? morningAndEviningNotificationFrequancy,
  }) {
    return NotificationState(
      fajarAlarmStatus: fajarAlarmStatus ?? this.fajarAlarmStatus,
      duharAlarmStatus: duharAlarmStatus ?? this.duharAlarmStatus,
      asrAlarmStatus: asrAlarmStatus ?? this.asrAlarmStatus,
      maghribAlarmStatus: maghribAlarmStatus ?? this.maghribAlarmStatus,
      ishaAlarmStatus: ishaAlarmStatus ?? this.ishaAlarmStatus,
      salahNabiNotificationStatus:
          salahNabiNotificationStatus ?? this.salahNabiNotificationStatus,
      morningAndEviningNotificationStatus:
          morningAndEviningNotificationStatus ??
              this.morningAndEviningNotificationStatus,
      fajarAlarmSound: fajarAlarmSound ?? this.fajarAlarmSound,
      duharAlarmSound: duharAlarmSound ?? this.duharAlarmSound,
      asrAlarmSound: asrAlarmSound ?? this.asrAlarmSound,
      maghribAlarmSound: maghribAlarmSound ?? this.maghribAlarmSound,
      ishaAlarmSound: ishaAlarmSound ?? this.ishaAlarmSound,
      salahNabiNotificationSound:
          salahNabiNotificationSound ?? this.salahNabiNotificationSound,
      salahNabiNotificationFrequancy:
          salahNabiNotificationFrequancy ?? this.salahNabiNotificationFrequancy,
      morningAndEviningNotificationFrequancy: morningAndEviningNotificationFrequancy ??
          this.morningAndEviningNotificationFrequancy,
    );
  }
}
