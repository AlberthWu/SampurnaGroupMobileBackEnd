import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/service/global.dart';
import 'package:asm/app/screens/authorization/forgot_password.dart';
import 'package:asm/app/views/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  globalService get service => GetIt.I<globalService>();
  late APIResponse<String> _apiResponse;

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
      overlayBackgroundColor: sgBlack,
      circularProgressColor: sgGold,
      appIcon: Image.asset(
        'assets/logo/loading.gif',
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
                  height: size.height * .4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      SGTextFormField(
                        icon: Icons.alternate_email,
                        label: "Email",
                        controller: emailController,
                        enabled: true,
                        border: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SGTextFormField(
                        icon: Icons.lock,
                        label: "Password",
                        obscureText: true,
                        controller: passwordController,
                        enabled: true,
                        border: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // context.read<UserBloc>().add(
                          //       SignIn(
                          //         email: emailController.text,
                          //         password: passwordController.text,
                          //       ),
                          //     );

                          var valid = await checkExpired();

                          if (valid) {
                            context.goNamed('main_page');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Masa  berlaku sudah habis, silakan hubungi tim IT.',
                                      style: TextStyle(
                                          color: appWhite,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    sgSizedBoxHeight
                                  ],
                                ),
                                backgroundColor: sgRed,
                              ),
                            );
                          }
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
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const ForgotPasswordScreen(),
                              type: PageTransitionType.bottomToTop,
                            ),
                          );
                        },
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Forgot Password? ',
                                  style: TextStyle(
                                    color: sgBlack,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Reset Here',
                                  style: TextStyle(
                                    color: sgRed,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushReplacement(
                      //       context,
                      //       PageTransition(
                      //         child: const RegisterScreen(),
                      //         type: PageTransitionType.bottomToTop,
                      //       ),
                      //     );
                      //   },
                      //   child: Center(
                      //     child: Text.rich(
                      //       TextSpan(
                      //         children: [
                      //           TextSpan(
                      //             text: 'Register',
                      //             style: TextStyle(
                      //               color: sgGold,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * .8,
                  height: size.height * .3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Version ",
                            style: TextStyle(
                              color: sgGrey,
                              fontFamily: 'Nexa',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            versionNumber,
                            style: TextStyle(
                              color: sgGold,
                              fontFamily: 'Nexa',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      sgSizedBoxHeight,
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

  Future<bool> checkExpired() async {
    _apiResponse = await service.GetServerDatetime();

    var today = DateTime.parse(_apiResponse.data.substring(1, 11));
    var expired = DateTime.parse("2023-03-03");

    bool valid = today.isBefore(expired);

    return valid;
  }
}
