
import 'package:get_it/get_it.dart';
import 'package:alekhlas_teachers/screens/home/viewmodel/home_view_model.dart';
import 'package:alekhlas_teachers/screens/login/viewmodel/login_view_model.dart';
import 'package:alekhlas_teachers/screens/splash/view_model/splash_view_model.dart';
import 'package:alekhlas_teachers/services/firebase_services.dart';
import 'package:alekhlas_teachers/services/shared_pref_services.dart';

import 'services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => FirebaseServices());
  locator.registerLazySingleton(() => SharedPrefServices());
  locator.registerFactory(() => SplashViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => HomeViewModel());
}
