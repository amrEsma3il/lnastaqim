import 'package:equatable/equatable.dart';

class FontDownloadState extends Equatable {
  final double percentage;
  final bool isPlaying;
 
final bool isFinished ;
  const FontDownloadState({
    required this.percentage,
    required this.isPlaying,
required this.isFinished
  });



factory FontDownloadState.init()=>const FontDownloadState(
          percentage: 0,
          isPlaying: false,
          isFinished: false
        
        );
  @override
  List<Object> get props => [percentage, isPlaying,isFinished];

  FontDownloadState copyWith({
    double? percentage,
    bool? isPlaying,
    bool?isFinished
    
  }) {
    return FontDownloadState(
      isFinished: isFinished??this.isFinished,
      percentage: percentage ?? this.percentage,
      isPlaying: isPlaying ?? this.isPlaying,

    );
  }
}


