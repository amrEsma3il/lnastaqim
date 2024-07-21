import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRedirection extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    return null;
  }
}
