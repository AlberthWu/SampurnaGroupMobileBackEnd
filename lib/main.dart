import 'package:asm/app/constant/theme_constant.dart';
import 'package:asm/app/service/autocomplete_service.dart';
import 'package:asm/app/service/driver.dart';
import 'package:asm/app/service/employee.dart';
import 'package:asm/app/service/global.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:asm/app/service/orders/schedule.dart';
import 'package:asm/app/service/orders/ujt.dart';
import 'package:asm/app/views/splash/splash.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'package:asm/app/constant/color.dart';
import 'package:asm/app/constant/theme_manager.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:workmanager/workmanager.dart';
// import 'package:http/http.dart' as http;

void setupLocator() {
  GetIt.I.registerLazySingleton(() => globalService());
  GetIt.I.registerLazySingleton(() => autoCompleteService());
  GetIt.I.registerLazySingleton(() => employeeService());
  GetIt.I.registerLazySingleton(() => scheduleService());
  GetIt.I.registerLazySingleton(() => deliveryService());
  GetIt.I.registerLazySingleton(() => ujtService());
  GetIt.I.registerLazySingleton(() => driverService());
}

showNotification(id, title, body) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'basic_channel',
      title: title,
      body: body,
    ),
  );
}

const simplePeriodicTask = "SGTask";
void callbackDispacther() {
  Workmanager().executeTask((taskName, inputData) async {
    // int random = Random().nextInt(500);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    print(formattedDate);
    // await http.get(Uri.parse(sgBaseURL + 'employee/' + random.toString()),
    //     headers: {'Content-Type': 'application/json'}).then((data) {
    //   if (data.statusCode == 200) {
    //     final jsonData = json.decode(data.body)['data'];
    //     print("data: " + jsonData['name']);
    //     showNotification(
    //         jsonData['id'], "Informasi Karyawan", jsonData['name']);
    //   } else {
    //     print("no messgae");
    //   }
    // });

    return Future.value(true);
  });
}

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic',
      ),
    ],
    debug: true,
  );
  await Workmanager().initialize(callbackDispacther, isInDebugMode: true);

  // await Workmanager().registerPeriodicTask(
  //   "5",
  //   simplePeriodicTask,
  //   existingWorkPolicy: ExistingWorkPolicy.replace,
  //   frequency: Duration(
  //     minutes: 15,
  //   ),
  //   initialDelay: Duration(
  //     seconds: 1,
  //   ),
  //   constraints: Constraints(networkType: NetworkType.connected),
  // );
  Workmanager().registerPeriodicTask(
    simplePeriodicTask,
    simplePeriodicTask,
    frequency: Duration(seconds: 10),
    // initialDelay: Duration(seconds: 10),
  );

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
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });

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

  triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Simple Notification',
        body: 'Welcome the jungle',
      ),
    );
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
