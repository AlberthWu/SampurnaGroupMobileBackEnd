import 'package:asm/app/constant/color.dart';
import 'package:asm/app/screens/authorization/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

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
    return Scaffold(
      backgroundColor: appWhite,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appWhite,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: LoginScreen(),
                    type: PageTransitionType.bottomToTop,
                    duration: Duration(milliseconds: 300),
                  ),
                );
              }, //to login screen. We will update later
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text(
                'Skip',
                style: TextStyle(
                  color: sgGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Nexa',
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              CreatePage(
                image: 'assets/logo/loading.gif',
                title: titleOne,
                description: descriptionOne,
              ),
              CreatePage(
                image: 'assets/splash/splash_two.gif',
                title: titleTwo,
                description: descriptionTwo,
              ),
              CreatePage(
                image: 'assets/splash/splash_three.gif',
                title: titleThree,
                description: descriptionThree,
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: sgRed,
              ),
              child: IconButton(
                onPressed: () {
                  setState(
                    () {
                      if (currentIndex < 2) {
                        currentIndex++;
                        if (currentIndex < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      } else {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: LoginScreen(),
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    },
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Create the indicator decorations widget
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: sgRed,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  //Create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const CreatePage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Image.asset(image),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: sgRed,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nexa',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: sgGrey,
              fontFamily: 'Nexa',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
