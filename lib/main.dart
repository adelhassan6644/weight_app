import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:weight_app/presentation/splash_view/splash_screen.dart';
import 'package:weight_app/provider/auth_controller.dart';
import 'package:weight_app/provider/weight_controller.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'di.dart' as di;


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent));

  await di.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => di.sl<AuthController>()),
    ChangeNotifierProvider(create: (context) => di.sl<WeightController>()),
  ],
       child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:navigatorKey ,
      title: 'Weight App',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home:  const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

