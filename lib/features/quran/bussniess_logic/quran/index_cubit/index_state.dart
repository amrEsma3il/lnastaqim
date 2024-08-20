 import 'package:equatable/equatable.dart';

import '../../../data/models/quran_model.dart';
import '../../../data/repository/quran_repository.dart';


abstract class IndexState extends Equatable {

  
}


class SurahIndexState extends IndexState {
  // List<SurahIndex> sowerIndex=QuranRepository.getSowarIndex();
 static const int selrctor=0;
 static final List<SurahIndex> indexList=QuranRepository.getSowarIndex();
 
  @override
  // TODO: implement props
  List<Object?> get props => [selrctor,indexList];

   
  
}

class ChapterIndexState extends IndexState {
    static const int selrctor=1;
  static final List<ChapterIndex> indexList=QuranRepository.getChaptersIndex();
 
  @override
  List<Object?> get props => [selrctor,indexList];
  
}
class HizbIndexState extends IndexState {
    static const int selrctor=2;
  static final List<HizbIndex> indexList=QuranRepository.getHizpIndex();
 
  @override
  List<Object?> get props => [selrctor,indexList];  
}



