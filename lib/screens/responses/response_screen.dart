
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dado/providers/app_color_provider.dart';
import 'package:multi_dado/providers/class_provider.dart';
import 'package:multi_dado/screens/class/class_screen.dart';
import 'package:multi_dado/screens/home/home_screen.dart';
import 'package:multi_dado/utils/app_color.dart';

class ResponseScreen extends ConsumerWidget{

  static String routeName = "response/";

  final bool value;
  final String? trueAnswer;
  ResponseScreen({required this.value, this.trueAnswer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    AppColor appColor = AppColor(value?Color.fromARGB(255, 24, 122, 89):const Color.fromARGB(255, 141, 18, 9),);
    return  Scaffold(
      body: Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      decoration: BoxDecoration(
        color: value?Color.fromARGB(255, 24, 122, 89):const Color.fromARGB(255, 141, 18, 9),
      ),
      child: ScrollConfiguration(behavior: const ScrollBehavior().copyWith(overscroll: true),
      child: Container(
        alignment: Alignment.topCenter,
        child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Text(value?"Felicidades":"Incorrecto",
            style: TextStyle(color: appColor.getContrastColor(), fontSize: 40, fontWeight: FontWeight.bold))
          ),
          Center(
            child: Text(value?"Respuesta Correcta":"Oh! Vaya Respuesta Incorrecta",
            style: TextStyle(color: appColor.getContrastColor(), fontSize: 18, fontWeight: FontWeight.bold))
          ),
          SizedBox(height: 100,),
          trueAnswer != null?
          Center(
            child: Text("La respuesta correcta era: \n${"\"" + (trueAnswer??"")}\"",
            style: TextStyle(color: appColor.getContrastColor(), fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
          )
          :SizedBox.shrink(),
          SizedBox(height: 200,),
          Center(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: appColor.getContrastColor()
                ),
                child: Text("Volver", style: TextStyle(color: appColor.secondary, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              onTap: (){
                ref.watch(classProvider.notifier).setValue(6);
                Navigator.of(context).maybePop();
              },
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: appColor.getContrastColor()
                ),
                child: Text("Salir", style: TextStyle(color: appColor.secondary, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              onTap: (){
                ref.watch(classProvider.notifier).setValue(6);
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
            ),
          )
        ])))),
    );
  }
}



