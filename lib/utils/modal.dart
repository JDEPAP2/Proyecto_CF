import 'package:flutter/material.dart';

class ModalUtil {
  static handleModal(Widget modal, BuildContext context, {AnimationController? controller, Color? barrierColor, double? elevation, bool drag = true}) async{
    return await showModalBottomSheet(
      elevation: elevation,
      barrierColor: barrierColor,
      enableDrag: drag,
      isDismissible: true,
      transitionAnimationController: controller,
      backgroundColor: Colors.transparent,
      context: context, 
      isScrollControlled: true,
      builder: (context)=> modal);
  }
  
  static handleDialog(Widget modal, BuildContext context, {bool? barrierDismissible,  AnimationController? controller}){
    return showDialog(
      barrierDismissible: barrierDismissible??false,
      context: context, 
      builder: (context) =>  modal);

  }

  static handleAlert(Widget modal, BuildContext context, int seconds, {bool autoDispose = true}) async{
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context, 
      builder: (context)=> modal
      );
    await Future.delayed(Duration(seconds: seconds));
    try {
      if(autoDispose){
        Navigator.maybeOf(context)?.pop();
      }
    } catch (e) {
    }
  }
}