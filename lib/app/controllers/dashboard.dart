import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/delivery/delivery_home.dart';
import 'package:asm/app/controllers/employee/employee_list.dart';
import 'package:asm/app/controllers/map_screen.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map> menuFavorites = [
    {
      'label': 'Sales',
      'icon': 'assets/icons/sales.png',
      'color': Colors.red,
    },
    {
      'label': 'Fleet',
      'icon': 'assets/icons/fleet.png',
      'color': Colors.blueGrey,
    },
    {
      'label': 'Purchase',
      'icon': 'assets/icons/purchase.png',
      'color': Colors.green
    },
    {
      'label': 'Inventory',
      'icon': 'assets/icons/inventory.png',
      'color': Colors.red
    },
    {
      'label': 'Finance',
      'icon': 'assets/icons/finance.png',
      'color': Colors.blueGrey
    },
    {
      'label': 'Payroll',
      'icon': 'assets/icons/payroll.png',
      'color': Colors.green
    },
    {
      'label': 'Employee',
      'icon': 'assets/icons/employee.png',
      'color': Colors.blueGrey,
    },
    {
      'label': 'GPS',
      'icon': 'assets/icons/gps.png',
      'color': Colors.blueGrey,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          color: sgRed,
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: const [
                            Icon(Icons.search_outlined),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Find services, transportation, or place',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Material(
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.notifications,
                        color: sgRed,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              runSpacing: 8,
              alignment: WrapAlignment.spaceBetween,
              children: [
                for (final menuFavorite in menuFavorites)
                  Material(
                    borderRadius: BorderRadius.circular(16),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      splashColor: menuFavorite['color'].withOpacity(0.4),
                      highlightColor: menuFavorite['color'].withOpacity(0.2),
                      onTap: () {
                        switch (menuFavorite['label']) {
                          case 'Sales':
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => DeliveryHome(),
                            ));
                            break;
                          case 'Employee':
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ListOfEmployee(),
                            ));
                            break;
                          default:
                        }
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
                                        color: menuFavorite['color']
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(
                                      menuFavorite['icon'],
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(menuFavorite['label']),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
