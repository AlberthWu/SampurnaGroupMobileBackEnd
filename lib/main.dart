import 'package:asm/app/service/autocomplete_service.dart';
import 'package:asm/app/service/driver.dart';
import 'package:asm/app/service/employee.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:asm/app/service/orders/schedule.dart';
import 'package:asm/app/service/orders/ujt.dart';
import 'package:asm/app/views/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:asm/app/constant/color.dart';
import 'package:asm/app/constant/theme_manager.dart';
import 'package:asm/app/controllers/bank/bank_list.dart';
import 'package:month_year_picker/month_year_picker.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => autoCompleteService());
  GetIt.I.registerLazySingleton(() => employeeService());
  GetIt.I.registerLazySingleton(() => scheduleService());
  GetIt.I.registerLazySingleton(() => deliveryService());
  GetIt.I.registerLazySingleton(() => ujtService());
  GetIt.I.registerLazySingleton(() => driverService());
}

void main() {
  setupLocator();
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: appWhite,
      // theme: lightTheme,
      // darkTheme: darkTheme,
      // themeMode: _themeManager.themeMode,
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en', 'US')],
      title: "Sampurna Group",
      home: SplashScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fitWidth,
              height: Get.height * 0.1,
              width: Get.width * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 10,
              ),
              child: Text(
                "Sampurna Group",
                style: _textTheme.headline4?.copyWith(
                  color: isDark ? appWhite : sgBlueDark,
                  fontFamily: "Nexa",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Switch(
            value: _themeManager.themeMode == ThemeMode.dark,
            onChanged: (newValue) {
              _themeManager.toggleTheme(newValue);
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: isDark ? sgBlueDark.withOpacity(0.5) : appWhite,
        child: Expanded(
          child: BankList(),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(splashColor: sgBlue),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
