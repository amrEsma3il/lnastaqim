import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FontDownloadPercentage extends Cubit<double> {
  FontDownloadPercentage() : super(0);
static FontDownloadPercentage get(BuildContext context)=>BlocProvider.of(context);


//value 0-->1
  getPercentage(int value){

log("from cubit");
double percent=value/603;

emit(percent);

}

}