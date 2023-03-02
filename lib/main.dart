import 'package:asm/app/bloc/user_bloc.dart';
import 'package:asm/app/constant/theme_constant.dart';
import 'package:asm/app/screens/authorization/login.dart';
import 'package:asm/app/screens/main_page.dart';
import 'package:asm/app/screens/splash/splash.dart';
import 'package:asm/app/service/autocomplete_service.dart';
import 'package:asm/app/service/driver.dart';
import 'package:asm/app/service/employee.dart';
import 'package:asm/app/service/global.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:asm/app/service/orders/schedule.dart';
import 'package:asm/app/service/orders/ujt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'package:asm/app/constant/color.dart';
import 'package:asm/app/constant/theme_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => globalService());
  GetIt.I.registerLazySingleton(() => autoCompleteService());
  GetIt.I.registerLazySingleton(() => employeeService());
  GetIt.I.registerLazySingleton(() => scheduleService());
  GetIt.I.registerLazySingleton(() => deliveryService());
  GetIt.I.registerLazySingleton(() => ujtService());
  GetIt.I.registerLazySingleton(() => driverService());
}

Future<void> main() async {
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
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/',
        name: 'main_page',
        builder: (context, state) {
          return const MainPage();
        },
        routes: [
          GoRoute(
            path: 'about',
            name: 'about',
            builder: (context, state) {
              return const AboutPage();
            },
          ),
        ],
      ),
    ],
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routerNeglect: true,
  );

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
    return BlocProvider(
      create: (context) => UserBloc(),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // if (state is UserSignedIn) {
          //   Navigator.push(
          //     context,
          //     PageTransition(
          //       child: DashboardPage(),
          //       type: PageTransitionType.bottomToTop,
          //       duration: Duration(milliseconds: 300),
          //     ),
          //   );
          // } else {
          //   Navigator.push(
          //     context,
          //     PageTransition(
          //       child: LoginScreen(),
          //       type: PageTransitionType.bottomToTop,
          //       duration: Duration(milliseconds: 300),
          //     ),
          //   );
          // }
        },
        child: MaterialApp(
          // routeInformationParser: router.routeInformationParser,
          // routerDelegate: router.routerDelegate,
          // routeInformationProvider: router.routeInformationProvider,
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
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sampurna Group"),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text('About'),
        ),
      ),
    );
  }
}
