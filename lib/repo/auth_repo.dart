import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

class AuthRepo {

  FirebaseAuth fireBaseAuth=  FirebaseAuth.instance;

  Future<Either<String,UserCredential>>  registerWithEmailAndPassword({ required String email, required String password })
  async {
    try{
      UserCredential  authResult = await fireBaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(authResult);

    }catch(ex){
      return Left(ex.toString());
    }
  }

  Future<Either<String,UserCredential>>  loginWithEmailAndPassword({ required String email, required String password })
  async {
   try{
     UserCredential authResult = await fireBaseAuth.signInWithEmailAndPassword(email: email, password: password);
     return Right(authResult);

   }catch(ex){
     return Left(ex.toString());
   }

  }

 User? getCurrentUser(){
 return fireBaseAuth.currentUser;
}


Future logOut()=>fireBaseAuth.signOut();
}