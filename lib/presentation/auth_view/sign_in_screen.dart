import 'package:flutter/material.dart';
import 'package:weight_app/presentation/auth_view/sign_up_screen.dart';
import 'package:weight_app/utill/dimensions..dart';
import '../../main.dart';
import '../../provider/auth_controller.dart';
import '../../utill/color_resources.dart';
import '../../utill/validation.dart';
import '../base/custom_app_bar.dart';
import '../base/custom_button.dart';
import '../base/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKeyLogin;


  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Sign In"),
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Form(
          key: _formKeyLogin,
          child: ListView(
          shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CustomTextFormField(
                  hint: "E-mail",
                  label: true,
                  type: TextInputType.emailAddress,
                  controller: _emailController,
                  valid: Validations.email,
                  fieldColor: ColorResources.lightPrimary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CustomTextFormField(
                  hint: "password",
                  label: true,
                  type: TextInputType.visiblePassword,
                  icon: Icons.lock_outline,
                  controller: _passwordController,
                  valid: Validations.password,
                  fieldColor: ColorResources.lightPrimary,
                ),
              ),
              Consumer<AuthController>(
                builder: (k,authController,child) {
                  if (authController.isLoading == true) {return const Center(
                    child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator()),
                  );}
                  else {
                    return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CustomButton(
                      btnTxt: "Log in",
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (!_formKeyLogin.currentState!.validate()) {
                          return;
                        }
                        _formKeyLogin.currentState!.save();
                        authController.login(context: context,
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                      },
                      backgroundColor: ColorResources.COLOR_GREY,
                    ),
                  );
                  }
                }
              ),
              TextButton(
                onPressed: () {
                  MyApp.navigatorKey.currentState!.push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => const SignUpScreen()),);
                },
                child: const Text("Sign Up",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  color: ColorResources.COLOR_GRAY
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
