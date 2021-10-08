import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alekhlas_teachers/enums/screen_state.dart';
import 'package:alekhlas_teachers/locator.dart';
import 'package:alekhlas_teachers/models/resources.dart';
import 'package:alekhlas_teachers/models/status.dart';
import 'package:alekhlas_teachers/screens/base_view_model.dart';
import 'package:alekhlas_teachers/services/firebase_services.dart';

class HomeViewModel extends BaseViewModel {

  Stream<DocumentSnapshot> getStatistics() {
    return locator<FirebaseServices>().getDashboardStatistics();
  }

}
