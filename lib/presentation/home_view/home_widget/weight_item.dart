import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weight_app/utill/media_query_values.dart';
import 'package:provider/provider.dart';
import '../../../data/model/weight_model.dart';
import '../../../provider/weight_controller.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions..dart';
import '../../base/bottom_sheet.dart';
import 'package:weight_app/utill/extensions.dart';
class WeightItem extends StatelessWidget {

  final  WeightModel data ;

   const WeightItem({required this.data ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Container(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          height: context.height*0.15,
          width: context.width,
          decoration: BoxDecoration(
            color: ColorResources.lightPrimary,
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "Weight : ${data.weight.toString()}"),
                  IconButton(
                      onPressed: () async {
                        Provider.of<WeightController>(context,
                            listen: false)
                            .bottomSheetMode();
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return AddBottomSheet(
                              isEdit: true,
                              id: data.id,
                            );
                          },
                        ).then((value) async {
                          log('bottom Sheet ended');
                          Provider.of<WeightController>(context,
                              listen: false)
                              .nonBottomSheetMode();
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 25,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "Created at : ${data.createdAt?.dateTimeFormat()}"),
                  IconButton(
                      onPressed: () async {
                        Provider.of<WeightController>(context,
                            listen: false)
                            .deleteWeight(docRef: data.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ))
                ],
              ),
            ],
          )),
    );
  }
}
