import 'package:equatable/equatable.dart';

// State class for the Cubit
class MemorizedVerseState extends Equatable {
  final bool isVisible;
  final List<int> versesNum;

  const MemorizedVerseState({required this.isVisible, required this.versesNum});

  // Factory method for initializing the state with default values
  factory MemorizedVerseState.initial() {
    return const MemorizedVerseState(
      isVisible: true,
      versesNum: [],
    );
  }

  // CopyWith method for state cloning with updates
  MemorizedVerseState copyWith({bool? isVisible, List<int>? versesNum}) {
    return MemorizedVerseState(
      isVisible: isVisible ?? this.isVisible,
      versesNum: versesNum ?? this.versesNum, // Deep copy for immutability
    );
  }

  @override
  List<Object> get props => [isVisible, versesNum];
}

