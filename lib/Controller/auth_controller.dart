import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/UI/auth_view/sign_in_screen.dart';
import 'package:weight_app/UI/home_view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import '../UI/base/custom_snackbar.dart';
import '../main.dart';
import '../repo/auth_repo.dart';

class AuthController extends ChangeNotifier {
  AuthRepo authRepo;

  AuthController({required this.authRepo});

  UserCredential? user;
  bool _isLoading = false;
  bool _isSignUp = false;

  bool get isLoading => _isLoading;
  bool get isSignUp => _isSignUp;

  login(
      {required String email,
      required String password,
      required context}) async {
    _isLoading = true;
    notifyListeners();
    Either<String, UserCredential> response = await authRepo
        .loginWithEmailAndPassword(email: email, password: password);
    response.fold((fail) {
      showCustomSnackBar(message: fail, context: context);
    }, (userCredential) {
      user = userCredential;
      MyApp.navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen()),
          (route) => false);
    });

    _isLoading = false;
    notifyListeners();
  }

  signUp(
      {required String email,
        required String password,
        required context}) async {
    _isSignUp = true;
    notifyListeners();
    Either<String, UserCredential> response = await authRepo
        .registerWithEmailAndPassword(email: email, password: password);
    response.fold((fail) {
      showCustomSnackBar(message: fail, context: context);
    }, (userCredential) {
      user = userCredential;
      MyApp.navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()),(route) => false);
    });

    _isSignUp = false;
    notifyListeners();
  }

  checkIsUserLogIn() {
    User? currentUser = authRepo.getCurrentUser();
    if (currentUser != null) {
      MyApp.navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen()),
          (route) => false);
    } else {
      MyApp.navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const SignInScreen()),
          (route) => false);
    }
  }

  logOut() async {
    await authRepo.logOut();
    MyApp.navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => const SignInScreen()),
        (route) => false);
  }
}
