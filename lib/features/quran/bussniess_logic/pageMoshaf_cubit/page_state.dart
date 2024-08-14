import 'package:equatable/equatable.dart';

import '../../data/models/surahs_model.dart';


class MoshafPageState extends Equatable {
  final int pageNum,ayahIndex;

  const MoshafPageState({required this.ayahIndex, 
    required this.pageNum,
  });


factory MoshafPageState.initial() {
    return  const MoshafPageState(
  pageNum: 604, ayahIndex: 6236,
    );
  }
  // Method to copy the state and update values
  MoshafPageState copyWith({
    List<List<Ayah>>? pageAyahs,
    int? pageNum,int? ayahIndex
  }) {
    return MoshafPageState(
   
      pageNum: pageNum ?? this.pageNum, ayahIndex: ayahIndex??this.ayahIndex,
    );
  }

  @override
  List<Object> get props => [pageNum,ayahIndex];
}
