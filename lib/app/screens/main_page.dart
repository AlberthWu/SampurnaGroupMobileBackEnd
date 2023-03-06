import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/constant/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Sampurna Group"),
      //   backgroundColor: sgRed,
      //   elevation: 0.0,
      // ),
      body: Container(
        width: size.width,
        height: size.height,
        color: sgWhite,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: size.height * .2,
                  child: Stack(
                    children: [
                      Container(
                        height: (size.height * .18) * .7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          color: sgRed,
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            left: 16.0,
                          ),
                          child: Text(
                            'Sampurna Group',
                            style: TextStyle(
                              fontSize: 18,
                              color: sgWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nexa',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 45,
                        left: 30,
                        right: 30,
                        child: Container(
                          height: (size.height * .18) * .7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: sgWhite,
                            border: Border.all(
                              width: 1,
                              color: sgBlack,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: (size.width - 120) * .2,
                                  child: Image.asset('assets/logo/ASM.png'),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: (size.width - 120) * .7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        introTitleOne,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Nexa',
                                        ),
                                      ),
                                      Text(
                                        introDescriptionOne,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Nexa',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: size.height * .13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: sgRed,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            width: (size.width - 40) * .3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: sgWhite,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: (size.width - 40) * .2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        color: sgWhite,
                                      ),
                                    ),
                                    Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: sgWhite,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: (size.width - 40) * .2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        color: sgWhite,
                                      ),
                                    ),
                                    Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: sgWhite,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: (size.width - 40) * .2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        color: sgWhite,
                                      ),
                                    ),
                                    Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: sgWhite,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: size.height * .6,
                  color: sgWhite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
