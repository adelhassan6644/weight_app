import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../presentation/base/custom_snackbar.dart';
import '../repo/weight_repo.dart';

class WeightController extends ChangeNotifier {
  WeightRepo weightRepo;


  WeightController({required this.weightRepo});



  bool isBottomSheet = false ;

  Query getWeight() {
    return weightRepo.getWeightData();
  }

  addWeight({required double weight, cont}) async {
    final response = await weightRepo.addWeight(weight: weight,);
    response.fold((fail) {
      showCustomSnackBar(message: fail, context: cont, isError: true);
    }, (success) {
      showCustomSnackBar(message: "success", context: cont);
    });
  }

  editWeight({required double weight, docRef, cont}) async {
    final response =
        await weightRepo.editWeight(weight: weight, docRef: docRef);
    response.fold((fail) {
      showCustomSnackBar(message: fail, context: cont, isError: true);
    }, (success) {
      showCustomSnackBar(message: "Weight Updated", context: cont);
    });
  }

  deleteWeight({required docRef}) async {
    final response =
        await weightRepo.deleteWeight( docRef: docRef);
    response.fold((fail) {
      log("fail");
       // showCustomSnackBar(message: "fail when delete weight", context: cont, isError: true);
    }, (success) {
      log("success");
       // showCustomSnackBar(message: "Weight deleted", context: cont);
    });
  }

  bottomSheetMode(){
    isBottomSheet = true;
    notifyListeners();
  }

  nonBottomSheetMode(){
    isBottomSheet = false;
    notifyListeners();
  }
}
