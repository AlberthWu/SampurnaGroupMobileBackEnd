import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    final List<Map> menuFavorites = [
      {
        'label': 'Sales',
        'icon': 'assets/icons/sales.png',
        'color': Colors.red,
        'url': 'delivery_list',
      },
      {
        'label': 'Fleet',
        'icon': 'assets/icons/fleet.png',
        'color': Colors.blueGrey,
        'url': '',
      },
      {
        'label': 'Purchase',
        'icon': 'assets/icons/purchase.png',
        'color': Colors.green,
        'url': '',
      },
      {
        'label': 'Inventory',
        'icon': 'assets/icons/inventory.png',
        'color': Colors.red,
        'url': '',
      },
      {
        'label': 'Finance',
        'icon': 'assets/icons/finance.png',
        'color': Colors.blueGrey,
        'url': '',
      },
      {
        'label': 'Payroll',
        'icon': 'assets/icons/payroll.png',
        'color': Colors.green,
        'url': '',
      },
      {
        'label': 'Employee',
        'icon': 'assets/icons/employee.png',
        'color': Colors.blueGrey,
        'url': 'employee_list',
      },
      {
        'label': 'GPS',
        'icon': 'assets/icons/gps.png',
        'color': Colors.blueGrey,
        'url': '',
      },
    ];

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: sgWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height * .23,
              child: Stack(
                children: [
                  Container(
                    height: (size.height * .18) * .8,
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
                        top: 20.0,
                        left: 20.0,
                      ),
                      child: Text(
                        'Sampurna Group',
                        style: TextStyle(
                          fontSize: 24,
                          color: sgWhite,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nexa',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 15,
                    right: 15,
                    child: Container(
                      height: (size.height * .18) * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: sgWhite,
                        border: Border.all(
                          width: 1,
                          color: sgGoldLight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: (size.width - 120) * .25,
                              child: Image.asset('assets/logo/ASM.png'),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: (size.width - 120) * .75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Name",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nexa',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
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
                                  SizedBox(
                                    height: 8,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Information Technology | Manager",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: 'Nexa',
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
                  )
                ],
              ),
            ),
            Container(
              height: size.height * .15,
              child: Padding(
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
            ),
            Container(
              height: size.height * .62,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) => (index < menuFavorites.length)
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        // child: ItemWidget(product: menuFavorites[index]),
                        child: Material(
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
                                    height: 60,
                                    width: 60,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            height: 90,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: menuFavorites[index]
                                                      ['color']
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(16),
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
                      )
                    : Container(
                        child: const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                itemCount: menuFavorites.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
