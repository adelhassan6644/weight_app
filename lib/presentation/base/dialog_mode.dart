import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';



customDialog(BuildContext context,String massage) {
  return showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(30.0)),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100,
                    ),
                    const SizedBox(height: 10,),
                    Text(massage,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 5,),
                  ],
                ),
              ),

            ]),
      );
    },

    animationType: DialogTransitionType.slideFromRight,
    curve: Curves.easeInOutBack,
    duration: const Duration(milliseconds: 1000),
  );
}
