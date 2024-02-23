part of 'radio_cubit.dart';

@immutable
abstract class RadioState {}

class RadioInitial extends RadioState {}

class RadioLoading extends RadioState {}

class RadioPlaying extends RadioState {}

class RadioError extends RadioState {}
