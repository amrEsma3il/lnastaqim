import 'package:equatable/equatable.dart';

class MoshafBookmarkState extends Equatable {
  final bool isMark;
  final int pageNumber;

  const MoshafBookmarkState({required this.isMark, required this.pageNumber});



 factory MoshafBookmarkState.initial() {
   
    return  const MoshafBookmarkState(
      isMark: false,pageNumber: 0
    );
  }
 MoshafBookmarkState copyWith({
  int? pageNumber,
  bool? isMark,

  }) {
    return MoshafBookmarkState(
      isMark: isMark??this.isMark,
      pageNumber: pageNumber??this.pageNumber
    );
  }

  @override
  List<Object?> get props => [isMark,pageNumber];
}
