import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alekhlas_teachers/locator.dart';
import 'package:alekhlas_teachers/routs/app_router.dart';
import 'package:alekhlas_teachers/routs/routs_names.dart';
import 'package:alekhlas_teachers/screens/login/model/teacher_model.dart';
import 'package:alekhlas_teachers/services/firebase_services.dart';
import 'package:alekhlas_teachers/services/navigation_service.dart';

void main() async {
  await configureApp();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
      startLocale: Locale('ar', 'EG'),
      fallbackLocale:  Locale('ar', 'EG'),
      saveLocale: true,
      path: 'assets/translations',
      child: MyApp(),
    ),
  );
}

Future configureApp() async {
  // setUrlStrategy(PathUrlStrategy());
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'المعلم',
      theme: ThemeData(
          primaryColor: Color(0xFFFD5F00),
          primarySwatch: Colors.deepOrange,
          fontFamily: 'Cairo'),
      initialRoute: RouteName.SPLASH,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
