import 'package:equatable/equatable.dart';

import '../data/model/a7adith_model.dart';

abstract class HadithState {}

class HadithInitial extends HadithState {}

class HadithLoading extends HadithState {
 
}

class HadithLoaded extends HadithState {
  final List<A7adithModel> hadiths;
  HadithLoaded(this.hadiths);
}

class HadithError extends HadithState {
  final String message;
  HadithError(this.message);
}


class HadithDownloadProgress extends HadithState with EquatableMixin {
  final double progressBukhari;
  final double progressMuslim;
  final double progressAbuDawud;
  final double progressTirmidhi;
  final double progressNasai;
  final double progressIbnmajah;
  final double progressMalik;
  final double progressDarimi;
  final double progressAhmed;

  HadithDownloadProgress(
    this.progressBukhari,
    this.progressMuslim,
    this.progressAbuDawud,
    this.progressTirmidhi,
    this.progressNasai,
    this.progressIbnmajah,
    this.progressMalik,
    this.progressDarimi,
    this.progressAhmed,
  );

  factory HadithDownloadProgress.initial() {
    return HadithDownloadProgress(
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    );
  }

  HadithDownloadProgress copyWith({
    double? progressBukhari,
    double? progressMuslim,
    double? progressAbuDawud,
    double? progressTirmidhi,
    double? progressNasai,
    double? progressIbnmajah,
    double? progressMalik,
    double? progressDarimi,
    double? progressAhmed,
  }) {
    return HadithDownloadProgress(
      progressBukhari ?? this.progressBukhari,
      progressMuslim ?? this.progressMuslim,
      progressAbuDawud ?? this.progressAbuDawud,
      progressTirmidhi ?? this.progressTirmidhi,
      progressNasai ?? this.progressNasai,
      progressIbnmajah ?? this.progressIbnmajah,
      progressMalik ?? this.progressMalik,
      progressDarimi ?? this.progressDarimi,
      progressAhmed ?? this.progressAhmed,
    );
  }

  @override
  List<Object> get props => [
        progressBukhari,
        progressMuslim,
        progressAbuDawud,
        progressTirmidhi,
        progressNasai,
        progressIbnmajah,
        progressMalik,
        progressDarimi,
        progressAhmed,
      ];
}

