import 'package:asm/app/bloc/delivery/delivery_running_bloc.dart';
import 'package:asm/app/bloc/delivery/delivery_today_bloc.dart';
import 'package:asm/app/bloc/driver/driver_get_bloc.dart';
import 'package:asm/app/bloc/employee/employee_list_bloc.dart';
import 'package:asm/app/bloc/schedule/schedule_get_bloc.dart';
import 'package:asm/app/bloc/schedule/schedule_list_bloc.dart';
import 'package:asm/app/bloc/user_bloc.dart';
import 'package:asm/app/constant/theme_constant.dart';
import 'package:asm/app/screens/authorization/login.dart';
import 'package:asm/app/screens/delivery/delivery_add.dart';
import 'package:asm/app/screens/delivery/delivery_create.dart';
import 'package:asm/app/screens/delivery/delivery_list.dart';
import 'package:asm/app/screens/delivery/delivery_modify.dart';
import 'package:asm/app/screens/employee/employee_listing.dart';
import 'package:asm/app/screens/employee/employee_modify.dart';
import 'package:asm/app/screens/main_screen.dart';
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
import 'package:asm/app/constant/color_constant.dart';
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
        path: '/splash',
        name: 'splash',
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
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
          return MainScreen();
        },
        routes: [
          GoRoute(
            path: 'delivery',
            name: 'delivery_list',
            builder: (context, state) {
              return DeliveryList();
            },
            routes: [
              GoRoute(
                path: 'delivery-add/:id',
                name: 'delivery_add',
                builder: (context, state) {
                  String id = state.params['id'].toString();
                  return DeliveryAdd(
                    schedule_id: id,
                  );
                },
              ),
              GoRoute(
                path: 'delivery-create/:id',
                name: 'delivery_create',
                builder: (context, state) {
                  int id = int.parse(state.params['id'].toString());
                  return DeliveryCreate(
                    schedule_id: id,
                  );
                },
              ),
              GoRoute(
                path: 'delivery-modify/:id',
                name: 'delivery_modify',
                builder: (context, state) {
                  int id = int.parse(state.params['id'].toString());
                  return DeliveryModify(
                    delivery_id: id,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'employee',
            name: 'employee_list',
            builder: (context, state) {
              return EmployeeList();
            },
            routes: [
              GoRoute(
                path: 'employee-create/:id',
                name: 'employee_create',
                builder: (context, state) {
                  int id = int.parse(state.params['id'].toString());
                  return EmployeeModify(
                    id: id,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
    initialLocation: '/splash',
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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: sgGold));

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc()..add(CheckSignInStatus()),
        ),
        BlocProvider<EmployeeListBloc>(
          create: (context) => EmployeeListBloc(),
        ),
        BlocProvider<DeliveryTodayBloc>(
          create: (context) => DeliveryTodayBloc(),
        ),
        BlocProvider<DeliveryRunningBloc>(
          create: (context) => DeliveryRunningBloc(),
        ),
        BlocProvider<ScheduleGetBloc>(
          create: (context) => ScheduleGetBloc(),
        ),
        BlocProvider<DriverGetBloc>(
          create: (context) => DriverGetBloc(),
        ),
        BlocProvider<ScheduleListBloc>(
          create: (context) => ScheduleListBloc(),
        ),
      ],
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSignedIn) {
            router.goNamed('main_page');
          } else {
            router.goNamed('login');
          }
        },
        child: MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
          color: sgWhite,
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
          // home: const MainPage(),
        ),
      ),
    );
  }
}
