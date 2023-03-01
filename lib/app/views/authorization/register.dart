import 'package:asm/app/constant/color.dart';
import 'package:asm/app/views/authorization/register_controller.dart';
import 'package:asm/app/views/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController registerController = Get.put(RegisterController());
  bool _isLoading = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OverlayLoaderWithAppIcon(
      isLoading: _isLoading,
      overlayBackgroundColor: appWhite,
      circularProgressColor: appWhite,
      appIcon: Image.asset(
        'assets/splash/splash_one.gif',
      ),
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: ListView(
              children: [
                Container(
                  width: size.width * .8,
                  height: size.height * .3,
                  child: Image.asset(
                    'assets/icons/signin.png',
                  ),
                ),
                Container(
                  width: size.width * .8,
                  height: size.height * .7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SGTextField(
                        controller: registerController.nameController,
                        obscureText: false,
                        hintText: 'Enter Name',
                        icon: Icons.alternate_email,
                      ),
                      SGTextField(
                        controller: registerController.emailController,
                        obscureText: false,
                        hintText: 'Enter Email',
                        icon: Icons.alternate_email,
                      ),
                      SGTextField(
                        controller: registerController.passwordController,
                        obscureText: true,
                        hintText: 'Enter Password',
                        icon: Icons.lock,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await registerController.registerWithEmail();
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: sgRed,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: const Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
