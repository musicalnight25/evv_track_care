import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:healthcare/config/routes/app_router/router.dart';
import 'package:healthcare/config/routes/routes.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/network/network_service.dart';
import 'package:healthcare/src/auth/providers/auth_provider.dart';
import 'package:healthcare/src/demo/providers/visit_provider.dart';
import 'package:healthcare/src/details/provider/patient_details_provider.dart';
import 'package:healthcare/src/home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/helper/database/database_helper.dart';
import 'core/helper/remote_config_helper.dart';
import 'core/utils/size_config.dart';
import 'di_container.dart';
import 'firebase_options.dart';
import 'http_overrides.dart';
import 'src/splash/providers/splash_provider.dart';



/*
ann.muller@swiftdata.test

allenbaiyee@me.com
1qRKB8gtb

allenbaiyee@me.com
Ul1N12PrZ

#iMbu2017!


*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RemoteConfigService.instance.setupRemoteConfig();
  // await DatabaseHelper.instance.database;
  await Di.init();
  HttpOverrides.global = MyHttpOverrides();


  final dbHelper = DatabaseHelper.instance;
  await dbHelper.database;


  setPathUrlStrategy();
  runApp(MultiProvider(providers: [
    StreamProvider(create: (context) => Di.sl<NetworkService>().controller.stream, initialData: NetworkStatus.offline),

    ///
    ///
    ChangeNotifierProvider(create: (context) => Di.sl<SplashProvider>()),
    ChangeNotifierProvider(create: (context) => Di.sl<AuthProvider>()),
    ChangeNotifierProvider(create: (context) => Di.sl<HomeProvider>()),
    ChangeNotifierProvider(create: (context) => Di.sl<DemoProvider>()),
    ChangeNotifierProvider(create: (context) => Di.sl<PatientDetailsProvider>()),

    ///
    ///
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context2, Orientation orientation) {
            SizeConfig.init(context);
            return GetMaterialApp(
              /// TODO : CHANGE NAME IN APP_CONSTANTS
              title: AppConsts.appName,
              debugShowCheckedModeBanner: false,
              navigatorKey: rootNavigatorKey,
              onGenerateRoute: AppRouter.generateRoute,
              initialRoute: Routes.splash.path,
              color: AppColors.bgColor,
              // routerConfig: AppRouter.router,

              ///
              /// TODO : ADD THEME DATA AS PER YOUR NEED
              ///
              theme: ThemeData(
                  useMaterial3: false,
                  brightness: Brightness.light,
                  primaryColor: AppColors.theme,
                  scaffoldBackgroundColor: AppColors.bgColor,
                  dividerTheme: const DividerThemeData(color: AppColors.black, thickness: 1, space: 0),
                  appBarTheme: const AppBarTheme(
                   //  backgroundColor: AppColors.bgColor,
                    // foregroundColor: AppColors.white,
                    iconTheme: IconThemeData(
                      color: AppColors.white,
                    ),
                    color: AppColors.theme,
                  ),
                  floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.theme),
                  elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: AppColors.theme))),
            );
          },
        );
      },
    );
  }
}
