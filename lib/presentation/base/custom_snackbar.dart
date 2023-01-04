import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../../utill/color_resources.dart';


void showCustomSnackBar(  {required String message ,context,bool isError = false}) {
  showToast(message,
      context: context,
      fullWidth: true,
      textPadding:const EdgeInsets.symmetric(vertical: 20,) ,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      backgroundColor: isError ? Colors.red : ColorResources.primary,
      animation: StyledToastAnimation.slideFromLeft,
      reverseAnimation: StyledToastAnimation.slideFromRight,
      position: StyledToastPosition.top,
      animDuration:const Duration(milliseconds: 800) ,
      textStyle: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
      duration: const Duration(seconds: 2),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear


  );
}