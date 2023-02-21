import 'package:asm/app/constant/theme_constant.dart';
import 'package:asm/app/service/autocomplete_service.dart';
import 'package:asm/app/service/driver.dart';
import 'package:asm/app/service/employee.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:asm/app/service/orders/schedule.dart';
import 'package:asm/app/service/orders/ujt.dart';
import 'package:asm/app/views/authorization/login.dart';
import 'package:asm/app/views/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'package:asm/app/constant/color.dart';
import 'package:asm/app/constant/theme_manager.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:workmanager/workmanager.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => autoCompleteService());
  GetIt.I.registerLazySingleton(() => employeeService());
  GetIt.I.registerLazySingleton(() => scheduleService());
  GetIt.I.registerLazySingleton(() => deliveryService());
  GetIt.I.registerLazySingleton(() => ujtService());
  GetIt.I.registerLazySingleton(() => driverService());
}

getData() {
  print("get data from api");
}

const taskName = 'notification';

void callbackDispacther() {
  Workmanager().executeTask((taskName, inputData) {
    switch (taskName) {
      case 'notification':
        getData();
        break;
      default:
    }
    return Future.value(true);
  });
}

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispacther, isInDebugMode: true);

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

  backgroundProcess() {
    var uniqueID = DateTime.now().second.toString();

    Workmanager().registerPeriodicTask(
      uniqueID,
      taskName,
      initialDelay: Duration(
        seconds: 15,
      ),
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  @override
  void initState() {
    // backgroundProcess();
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
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
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
