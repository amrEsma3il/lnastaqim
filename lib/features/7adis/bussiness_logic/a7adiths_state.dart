import '../data/model/a7adith_model.dart';

abstract class HadithState {}

class HadithInitial extends HadithState {}

class HadithLoading extends HadithState {}

class HadithLoaded extends HadithState {
  final List<A7adithModel> hadiths;
  HadithLoaded(this.hadiths);
}

class HadithError extends HadithState {
  final String message;
  HadithError(this.message);
}

class HadithDownloadProgress extends HadithState {
  final double progress;
  HadithDownloadProgress(this.progress);
}
