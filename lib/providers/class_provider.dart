import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dado/providers/app_color_provider.dart';
import 'package:multi_dado/utils/app_color.dart';
import 'package:multi_dado/utils/files.dart';

final classProvider = StateNotifierProvider<ClassProviderController, AsyncValue<int>>((ref) => ClassProviderController(ref:ref));

class ClassProviderController extends StateNotifier<AsyncValue<int>>{
  StateNotifierProviderRef<ClassProviderController, AsyncValue<int>> ref;
  ClassProviderController({required this.ref}): super(const AsyncData(6));
  

  void setValue(int v){
    final appColor = ref.read(appColorProvider.notifier);
    state = AsyncData(v);
    if (v < 4) {
      appColor.setColor(Multiclass.getColor(v));
    }else{
      appColor.setColor(Color.fromARGB(255, 255, 255, 255));
    }
  }

  void setLoading(){
    state = AsyncLoading();
  }

}