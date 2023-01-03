import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_app/Controller/auth_controller.dart';
import 'package:weight_app/Controller/weight_controller.dart';
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



  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}