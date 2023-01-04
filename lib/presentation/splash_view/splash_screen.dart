import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_controller.dart';
import '../../utill/color_resources.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
Future.delayed(const Duration(milliseconds: 5000),(){
  Provider.of<AuthController>(context,listen: false).checkIsUserLogIn();
});
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Center(
        child: Icon(Icons.ac_unit_sharp,size: 200,color: ColorResources.cahtColor,),),
    );
  }
}
