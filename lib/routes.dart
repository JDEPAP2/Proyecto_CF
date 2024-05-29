import 'package:flutter/material.dart';
import 'package:multi_dado/screens/class/class_screen.dart';
import 'package:multi_dado/screens/home/home_screen.dart';
import 'package:multi_dado/screens/init_screen.dart';
import 'package:multi_dado/screens/tutorials/tutorial_screen.dart';

final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ClassScreen.routeName: (context) => const ClassScreen(),
  TutorialScreen.routeName: (context) => const TutorialScreen(),
};
