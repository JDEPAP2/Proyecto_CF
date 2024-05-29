import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class Multiclass{
  static Future<Map<String,dynamic>> getData() async {
  var input = await File("data.json").readAsString();
  return jsonDecode(input);
  }

  static Color getColor(int i){
    return  [Color.fromARGB(255, 255, 33, 18),
            Color.fromARGB(255, 12, 146, 255),
            Color.fromARGB(255, 16, 172, 22), 
            Color.fromARGB(255, 221, 191, 23)][i];
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