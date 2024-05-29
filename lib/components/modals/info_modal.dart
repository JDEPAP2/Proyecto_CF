
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoModal extends ConsumerWidget{

  final Color color;
  final String name;
  final Map<String,dynamic> data;
  InfoModal({required this.color,required this.name, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return  Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      height: MediaQuery.of(context).size.height * 0.8,
      child: ScrollConfiguration(behavior: const ScrollBehavior().copyWith(overscroll: true),
      child: Container(
        alignment: Alignment.topCenter,
        child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Center(child: Text(name, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),))
        ]))));
  }
}



