import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Multiclass{
  static Future<Map<String,dynamic>> getData() async {
    String jsonString = await rootBundle.loadString("assets/data.json");
    return jsonDecode(jsonString);
  }

  static Color getColor(int i){
    return  [Color.fromARGB(255, 138, 10, 1),
            Color.fromARGB(255, 2, 39, 139),
            Color.fromARGB(255, 2, 102, 5), 
            Color.fromARGB(255, 133, 113, 0)][i];
  }

  static LinearGradient getGradient(int i){
    return [const LinearGradient(colors: [Color.fromARGB(255, 255, 33, 18), Color.fromARGB(255, 255, 80, 36)]),
            const LinearGradient(colors: [Color.fromARGB(255, 12, 146, 255), Color.fromARGB(255, 0, 204, 255)]),
            const LinearGradient(colors: [Color.fromARGB(255, 28, 224, 35), Color.fromARGB(255, 152, 221, 23)]),
            const LinearGradient(colors: [Color.fromARGB(255, 224, 202, 0), Color.fromARGB(255, 207, 162, 12)])][i];
  }

  static String getName(int i){
    return ["Hardware",
            "Software",
            "Contenidos",
            "Telecomunicaciones"][i];
  }
}