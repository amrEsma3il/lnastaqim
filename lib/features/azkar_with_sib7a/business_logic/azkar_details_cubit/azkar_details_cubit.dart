import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';

import '../../data/repository/azkar_repository.dart';

class AzkarDetailsCubit extends Cubit<List<AzkarModel>> {
  AzkarDetailsCubit() : super(AzkarRepository.getAzkarDetails());

  getAzkarDetails() => emit(state);
}
