import 'package:flutter/material.dart';
import '../../utill/color_resources.dart';


class NoDataView extends StatelessWidget {
  final String message;
  const NoDataView( {required this.message ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.ac_unit_sharp,size: 200,color: ColorResources.cahtColor,),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              message,
              style: const TextStyle(
                  fontSize: 30,
                  color: ColorResources.cahtColor),
            ),
          ),
        ],
      ),
    );
  }
}
