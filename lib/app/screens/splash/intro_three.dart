import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/constant/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPageThree extends StatelessWidget {
  const IntroPageThree({super.key});

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
                    'https://assets5.lottiefiles.com/private_files/lf30_3lflolyo.json'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
