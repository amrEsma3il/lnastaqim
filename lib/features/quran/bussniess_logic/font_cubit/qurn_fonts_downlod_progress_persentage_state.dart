import 'package:equatable/equatable.dart';

class FontDownloadState extends Equatable {
  final double percentage;
  final bool isPlaying;
 final Map<int, bool> loadedPages;
final bool isFinished ;
  const FontDownloadState({
    required this.percentage,
    required this.isPlaying,
required this.isFinished,
    required this.loadedPages,  
  });



factory FontDownloadState.init()=>const FontDownloadState(
          percentage: 0,
          isPlaying: false,
          isFinished: false,
          loadedPages: {},
        
        );
  @override
  List<Object> get props => [percentage, isPlaying,isFinished, loadedPages];

  FontDownloadState copyWith({
    double? percentage,
    bool? isPlaying,
    bool?isFinished,
    Map<int, bool>? loadedPages,
    
  }) {
    return FontDownloadState(
      isFinished: isFinished??this.isFinished,
      percentage: percentage ?? this.percentage,
      isPlaying: isPlaying ?? this.isPlaying,
      loadedPages: loadedPages ?? this.loadedPages,

    );
  }
}


