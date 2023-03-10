import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Map> menuFavorites = [
    {
      'label': 'Sales',
      'icon': 'assets/icons/sales.gif',
      'color': Colors.blueGrey,
      'url': 'delivery_list',
    },
    {
      'label': 'Fleet',
      'icon': 'assets/icons/fleet2.gif',
      'color': Colors.green,
      'url': '',
    },
    {
      'label': 'Purchase',
      'icon': 'assets/icons/purchase2.gif',
      'color': Colors.blueGrey,
      'url': '',
    },
    {
      'label': 'Finance',
      'icon': 'assets/icons/finance.gif',
      'color': Colors.green,
      'url': '',
    },
    {
      'label': 'Payroll',
      'icon': 'assets/icons/payroll.gif',
      'color': Colors.blueGrey,
      'url': '',
    },
    {
      'label': 'Employee',
      'icon': 'assets/icons/employee.gif',
      'color': Colors.green,
      'url': 'employee_list',
    },
    {
      'label': 'GPS',
      'icon': 'assets/icons/gps.gif',
      'color': Colors.blueGrey,
      'url': '',
    },
    {
      'label': 'More',
      'icon': 'assets/icons/more.gif',
      'color': Colors.green,
      'url': '',
    },
  ];

  final List<Map> imageList = [
    {"id": 1, "image_path": 'assets/icons/loading_1.jpg'},
    {"id": 2, "image_path": 'assets/icons/loading_2.jpg'},
    {"id": 3, "image_path": 'assets/icons/loading_3.jpg'},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: sgWhite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height * .23,
              child: Stack(
                children: [
                  Container(
                    height: (size.height * .20) * .75,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: sgRed,
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 25.0,
                        bottom: 15.0,
                      ),
                      child: Text(
                        'Semangat Kerja!',
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
                    top: 50,
                    left: 20,
                    right: 20,
                    bottom: 10,
                    child: Container(
                      height: (size.height * .25) * .75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: sgWhite,
                        border: Border.all(
                          width: 1,
                          color: sgRed,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: (size.width - 100) * .26,
                              child: Image.asset('assets/images/logo.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: (size.width - 100) * .65,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Nurhida Chaniago",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nexa',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: sgRed,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: sgRed,
                                    ),
                                    child: Text(
                                      "PT Alam Sampurna Makmur",
                                      style: TextStyle(
                                        color: sgWhite,
                                        fontSize: 12,
                                        fontFamily: 'Nexa',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Accounting | Supervisor",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
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
            Container(
              height: size.height * .12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 100,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: sgRed,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: sgWhite,
                                  ),
                                  height: 75,
                                  width: 125,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.more_time_outlined,
                                                size: 18,
                                                color: Color.fromARGB(
                                                    255, 214, 137, 0),
                                              ),
                                              SizedBox(width: 5.0),
                                              Text(
                                                'Lembur',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Text(
                                            '0',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: sgWhite,
                                  ),
                                  height: 75,
                                  width: 125,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.date_range_outlined,
                                                size: 18,
                                                color: Color.fromARGB(
                                                    255, 214, 137, 0),
                                              ),
                                              SizedBox(width: 5.0),
                                              Text(
                                                'Saldo Cuti',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Text(
                                            '0',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: const SaldoIcons(
                            icons: Icons.timelapse_outlined, text: 'Kehadiran'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: const SaldoIcons(
                            icons: Icons.money_outlined, text: 'Kasbon'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: const SaldoIcons(
                            icons: Icons.file_open_outlined, text: 'Slip Gaji'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: size.height * .32,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) => Material(
                    color: sgWhite,
                    borderRadius: BorderRadius.circular(16),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      splashColor:
                          menuFavorites[index]['color'].withOpacity(0.4),
                      highlightColor:
                          menuFavorites[index]['color'].withOpacity(0.2),
                      onTap: () {
                        menuFavorites[index]['url'] != ""
                            ? context.goNamed(menuFavorites[index]['url'])
                            : null;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 65,
                              width: 65,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        color: menuFavorites[index]['color']
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(
                                      menuFavorites[index]['icon'],
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(menuFavorites[index]['label']),
                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: menuFavorites.length,
                ),
              ),
            ),
            Stack(
              children: [
                InkWell(
                  onTap: () {},
                  child: CarouselSlider(
                    items: imageList
                        .map(
                          (item) => Image.asset(
                            item['image_path'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      height: size.height * .25,
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 500),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      aspectRatio: 2,
                      viewportFraction: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50.0,
        backgroundColor: sgWhite,
        color: sgRed,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              context.goNamed('profile');
              break;
            default:
          }
        },
        items: const [
          Icon(
            Icons.assignment_outlined,
            color: sgWhite,
            size: 30,
          ),
          Icon(
            Icons.home_outlined,
            color: sgWhite,
            size: 30,
          ),
          Icon(
            Icons.person_outline,
            color: sgWhite,
            size: 30,
          ),
        ],
      ),
    );
  }
}

class SaldoIcons extends StatelessWidget {
  final IconData icons;
  final String text;

  const SaldoIcons({required this.icons, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: sgWhite, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              size: 20,
              icons,
              color: sgRed,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
