import 'package:flutter/material.dart';
import '../../utill/color_resources.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String btnTxt;
  final Color? backgroundColor;
   const CustomButton({Key? key, this.onTap, required this.btnTxt,  this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onTap == null
          ? ColorResources.getGreyColor(context)
          : backgroundColor ?? Theme.of(context).primaryColor,
      minimumSize: Size(MediaQuery.of(context).size.width, 75),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return TextButton(
      onPressed: onTap,
      style: flatButtonStyle,
      child: Text(btnTxt ,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3!.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorResources.COLOR_WHITE,
              fontSize: 20)),
    );
  }
}
