import 'package:alekhlas_teachers/routs/routing_data.dart';
import 'package:alekhlas_teachers/routs/routs_names.dart';
import 'package:alekhlas_teachers/screens/home/view/home_screen.dart';
import 'package:alekhlas_teachers/screens/login/view/login_screen.dart';
import 'package:alekhlas_teachers/screens/navigation/navigation_index.dart';
import 'package:alekhlas_teachers/screens/navigation/view/navigation_container.dart';
import 'package:alekhlas_teachers/screens/not_found_screen/not_found_screen.dart';
import 'package:alekhlas_teachers/screens/splash/splash_screen.dart';
import 'package:alekhlas_teachers/screens/system_users/view/system_users_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var uriData = Uri.parse(settings.name!);

    var routingData = RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );

    print('rout name : = ${routingData.route}');

    switch (routingData.route) {
      case RouteName.SPLASH:
        return _getPageRoute(SplashScreen(), settings);

      case RouteName.LOGIN:
        return _getPageRoute(LoginScreen(), settings);

      case RouteName.HOME:
        return _getPageRoute(
            NavigationContainer(HomeScreen(), HOME_INDEX), settings);

      case RouteName.SYSTEM_USERS:
        return _getPageRoute(
            NavigationContainer(SystemUsersScreen(), SYSTEM_USERS_INDEX),
            settings);

      default:
        return _getPageRoute(const NotFoundScreen(), settings);
    }
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget? child;
  final String? routeName;

  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
