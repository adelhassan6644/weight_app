import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weight_app/data/model/weight_model.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_controller.dart';
import '../../provider/weight_controller.dart';
import '../../utill/color_resources.dart';
import '../base/bottom_sheet.dart';
import '../base/custom_app_bar.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'home_widget/weight_item.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icons.logout,
        leadingAction: () {Provider.of<AuthController>(context, listen: false).logOut();},
        title: "Home Screen",
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
      body: PaginateFirestore(
        //item builder type is compulsory.
        itemBuilder: (context, documentSnapshots, index) {
          WeightModel weightData =
          WeightModel.fromJson( documentSnapshots[index].data()! as Map<String, dynamic>,documentSnapshots[index].id);
          return WeightItem(data: weightData);
        },
        query: Provider.of<WeightController>(context, listen: false).getWeight(),
        itemsPerPage: 5,
        itemBuilderType: PaginateBuilderType.listView,
        isLive: true,
      ),);
  }
}
