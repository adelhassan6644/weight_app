import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:weight_app/main.dart';
import '../presentation/base/custom_snackbar.dart';
import '../utill/app_storage_key.dart';

class WeightRepo {

  final collectionRef = FirebaseFirestore.instance.collection(AppStorageKey.weightRef);


  Query getWeightData(){
  return  collectionRef
      .orderBy('created_at', descending: true).where( "UID",isEqualTo:FirebaseAuth.instance.currentUser!.uid );
  }

  Future<Either<dynamic,dynamic>>  addWeight({required double  weight}) async {
  return  await collectionRef.doc().set(
      {"weight": weight,
      "created_at": Timestamp.now(),
      "UID":FirebaseAuth.instance.currentUser!.uid,
    }).then((value) {
      return Right(value);
    }).catchError((onError){
      return Left(onError.toString());
    });
  }

  Future<Either<dynamic,dynamic>>   editWeight({required String docRef,required double weight}) async {
 return   await collectionRef.doc(docRef).update({"weight": weight}).then((value) {
      return Right(value);
    }).catchError((onError){
      return Left(onError.toString());
    });
  }

  Future<Either<dynamic,dynamic>>   deleteWeight({required String docRef}) async {
    log(docRef);
    return   await collectionRef.doc(docRef).delete().then((value) {

      return const Right("success");
    }).catchError((error){
      return const Left("fail");
    });
  }
}
