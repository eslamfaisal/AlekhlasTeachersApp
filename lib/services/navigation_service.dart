import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,
      {Map<String, dynamic>? queryParams}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToAndClearStack(String routeName,
      {Map<String, String>? queryParams}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }

    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (r) => false);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
