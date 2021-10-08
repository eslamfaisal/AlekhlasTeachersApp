import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:alekhlas_teachers/locator.dart';
import 'package:alekhlas_teachers/routs/routs_names.dart';
import 'package:alekhlas_teachers/services/navigation_service.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(tr('no_page')),
              TextButton(
                onPressed: () {
                  locator<NavigationService>().navigateToAndClearStack(RouteName.HOME);
                },
                child: Text(tr('go_to_home')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
