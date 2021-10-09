import 'dart:convert';

import 'package:alekhlas_teachers/routs/routs_names.dart';
import 'package:alekhlas_teachers/screens/login/model/teacher_model.dart';
import 'package:alekhlas_teachers/services/firebase_services.dart';
import 'package:alekhlas_teachers/services/navigation_service.dart';
import 'package:alekhlas_teachers/utils/constants.dart';
import 'package:alekhlas_teachers/utils/shared_preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locator.dart';
import '../../base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  void checkLogin() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = await Future.value(prefs.getBool(LOGGED_IN) ?? false);
      if (isLoggedIn) {
        String userJsonString = await Future.value(prefs.getString(USER_DETAILS));
        Map<String, dynamic> user = await jsonDecode(userJsonString);
        TeacherModel userEvent = TeacherModel.fromJson(user);
        currentLoggedInUserData = userEvent;
        locator<FirebaseServices>().userController.add(userEvent);
        locator<NavigationService>().navigateToAndClearStack(RouteName.HOME);
      } else {
        locator<NavigationService>().navigateToAndClearStack(RouteName.LOGIN);
      }
    }catch(e){
      locator<NavigationService>().navigateToAndClearStack(RouteName.LOGIN);
    }

  }
}
