import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/constant/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPageTwo extends StatelessWidget {
  const IntroPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: sgWhite,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                companyName,
                style: TextStyle(
                  fontFamily: 'Nexa',
                ),
              ),
              const Text(
                introHeading,
                style: TextStyle(
                  fontFamily: 'Nexa',
                ),
              ),
              const Text(
                introDetail,
                style: TextStyle(
                  fontFamily: 'Nexa',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Lottie.network(
                    'https://assets4.lottiefiles.com/packages/lf20_1oky66dx.json'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
