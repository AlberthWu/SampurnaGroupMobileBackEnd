import 'package:asm/app/bloc/user_bloc.dart';
import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/service/global.dart';
import 'package:asm/app/screens/authorization/forgot_password.dart';
import 'package:asm/app/widget/forms/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserErrorState) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Text(
                                    state.errorMessage,
                                    style: TextStyle(
                                      color: sgRed,
                                      fontSize: 12,
                                      fontFamily: 'Nexa',
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                );
                              } else {
                                return Text("");
                              }
                            },
                          ),
                          SGTextFormField(
                            icon: Icons.alternate_email,
                            label: "Email",
                            controller: emailController,
                            enabled: true,
                            border: false,
                          ),
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserErrorState) {
                                if (state.errors!.isNotEmpty) {
                                  if (state.errors!.length > 0) {
                                    if (state.errors![0].field! == 'email') {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: Text(
                                          state.errors![0].errors!,
                                          style: TextStyle(
                                            color: sgRed,
                                            fontSize: 12,
                                            fontFamily: 'Nexa',
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      );
                                    }
                                  }
                                }
                                return Container();
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SGTextFormField(
                            icon: Icons.lock,
                            label: "Password",
                            obscureText: true,
                            controller: passwordController,
                            enabled: true,
                            border: false,
                          ),
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserErrorState) {
                                if (state.errors!.isNotEmpty) {
                                  if (state.errors!.length == 1) {
                                    if (state.errors![0].field! == 'password') {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: Text(
                                          state.errors![0].errors!,
                                          style: TextStyle(
                                            color: sgRed,
                                            fontSize: 12,
                                            fontFamily: 'Nexa',
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      );
                                    }
                                  } else if (state.errors!.length == 2) {
                                    if (state.errors![1].field! == 'password') {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: Text(
                                          state.errors![1].errors!,
                                          style: TextStyle(
                                            color: sgRed,
                                            fontSize: 12,
                                            fontFamily: 'Nexa',
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      );
                                    }
                                  }
                                }
                                return Text("");
                              } else {
                                return Text("");
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          context.read<UserBloc>().add(
                                SignIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
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
    var expired = DateTime.parse("2023-03-05");

    bool valid = today.isBefore(expired);

    return valid;
  }
}
