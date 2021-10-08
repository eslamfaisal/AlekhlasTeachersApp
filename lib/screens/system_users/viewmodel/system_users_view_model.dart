import 'package:alekhlas_teachers/enums/screen_state.dart';
import 'package:alekhlas_teachers/models/resources.dart';
import 'package:alekhlas_teachers/models/status.dart';
import 'package:alekhlas_teachers/screens/base_view_model.dart';
import 'package:alekhlas_teachers/screens/system_users/model/system_user_model.dart';
import 'package:alekhlas_teachers/services/firebase_services.dart';

import '../../../locator.dart';

class SystemUsersViewModel extends BaseViewModel {
  List<SystemUserModel> systemUsers = [];
  var _firebaseServices = locator<FirebaseServices>();

  void getSystemUsers() async {
    setState(ViewState.Busy);
    Resource<List<SystemUserModel>> response =
        await _firebaseServices.getSystemUsers();
    switch (response.status) {
      case Status.SUCCESS:
        this.systemUsers = response.data!;
        break;
      case Status.ERROR:
        break;
      default:
        print('wtf');
    }
    setState(ViewState.Idle);
  }

  void insert(int index, SystemUserModel user) {
    systemUsers.insert(index, user);
    setState(ViewState.Idle);
  }

  void deleteUser(int index) {
    _firebaseServices.deleteUser(systemUsers[index]);
    systemUsers.removeAt(index);
    setState(ViewState.Idle);
  }
}
