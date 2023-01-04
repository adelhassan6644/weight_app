import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weight_app/data/model/weight_model.dart';
import 'package:weight_app/utill/media_query_values.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_controller.dart';
import '../../provider/weight_controller.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions..dart';
import '../base/bottom_sheet.dart';
import '../base/custom_app_bar.dart';
import '../base/no_data_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingAction: () {
          Provider.of<AuthController>(context, listen: false).logOut();
        },
        title: "Home Page",
        showLeading: true,
      ),
      floatingActionButton: Consumer<WeightController>(builder: ((context, weightController, child) {
        return FloatingActionButton(
            backgroundColor: ColorResources.BACKGROUND_COLOR,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () async {
              await weightController.bottomSheetMode();
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return AddBottomSheet();
                },
              ).then((value) async {
                log('bottom Sheet ended');
                await weightController.nonBottomSheetMode();
              });
            });
      })),
      body: StreamBuilder<List<WeightModel>>(
        stream: Provider.of<WeightController>(context, listen: false).getWeight(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const NoDataView( message: 'No Data',);
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (c, index) => Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Container(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
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
                              "Weight : ${snapshot.data![index].weight.toString()}"),
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
                                      id: snapshot.data![index].id,
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
                              "Created at : ${snapshot.data![index].createdAt.toString()}"),
                          IconButton(
                              onPressed: () async {
                                Provider.of<WeightController>(context,
                                        listen: false)
                                    .deleteWeight(
                                        cont: context,
                                        docRef: snapshot.data![index].id);
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
            ),
          );
        },
      ),
    );
  }
}
