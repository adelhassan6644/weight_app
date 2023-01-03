import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:weight_app/data/model/weight_model.dart';
import '../utill/app_storage_key.dart';

class WeightRepo {
  final collectionRef =
      FirebaseFirestore.instance.collection(AppStorageKey.weightRef);
  final uID= FirebaseAuth.instance.currentUser!.uid;
  Stream<List<WeightModel>>getWeightData(){
  return  collectionRef.where( "UID",isEqualTo: uID)
      .orderBy('created_at', descending: false).snapshots().map((list) =>
      list.docs.map((doc) => WeightModel.fromJson(doc.data(),doc.id)).toList());
  }

  Future<Either<dynamic,dynamic>>  addWeight({required double  weight}) async {
  return  await collectionRef.doc().set({"weight": weight,
      "created_at": Timestamp.now(),
      "UID": uID,
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
    return   await collectionRef.doc(docRef).delete().then((value) {

      return Right(value);
    }).catchError((onError){
      return Left(onError.toString());
    });
  }
}
