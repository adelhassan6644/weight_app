import 'package:get_it/get_it.dart';
import 'package:weight_app/provider/auth_controller.dart';
import 'package:weight_app/provider/weight_controller.dart';
import 'package:weight_app/repo/auth_repo.dart';
import 'package:weight_app/repo/weight_repo.dart';


final sl = GetIt.instance;
init() async {

//repository
  sl.registerLazySingleton(() => AuthRepo());
  sl.registerLazySingleton(() => WeightRepo());


//controller
  sl.registerLazySingleton(() => AuthController(authRepo: sl()));
  sl.registerLazySingleton(() => WeightController(weightRepo: sl()));



}