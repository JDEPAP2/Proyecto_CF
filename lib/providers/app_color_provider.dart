import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dado/utils/app_color.dart';

final appColorProvider = StateNotifierProvider<AppColorController, AppColor>((ref) => AppColorController());

class AppColorController extends StateNotifier<AppColor>{
  AppColorController(): super(AppColor(Colors.white));

  void setColor(Color color){
    state = AppColor(color);
  }
}