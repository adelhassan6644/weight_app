import 'package:flutter/cupertino.dart';
import '../../utill/color_resources.dart';

Row titleRow({required String title}) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(
            color: ColorResources.primary,
            fontSize: 26,
            fontWeight: FontWeight.w600),
      ),
    ],
  );
}