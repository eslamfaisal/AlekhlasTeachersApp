import 'dart:async';
import 'dart:convert';

import 'package:alekhlas_teachers/models/resources.dart';
import 'package:alekhlas_teachers/models/status.dart';
import 'package:alekhlas_teachers/screens/login/model/teacher_model.dart';
import 'package:alekhlas_teachers/services/shared_pref_services.dart';
import 'package:alekhlas_teachers/utils/constants.dart';
import 'package:alekhlas_teachers/utils/shared_preferences_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../locator.dart';

class FirebaseServices {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  StreamController<TeacherModel> userController =
      StreamController<TeacherModel>();

  Future<Resource<TeacherModel>> getSystemUserProfile(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> value =
          await db.collection('system_users').doc(userId).get();
      if (value.exists) {
        TeacherModel userModel = TeacherModel.fromJson(value.data()!);

        userController.add(userModel);
        await locator<SharedPrefServices>().saveBoolean(LOGGED_IN, true);
        await locator<SharedPrefServices>()
            .saveString(USER_DETAILS, jsonEncode(userModel.toJson()));

        return Resource(Status.SUCCESS, data: userModel);
      } else {
        return Resource(Status.ERROR, errorMessage: tr('user_not_found'));
      }
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  User? getCurrentUserData() {
    return auth.currentUser;
  }

  void signOut() {
    auth.signOut();
  }

  Future<Resource<UserCredential>> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Resource(Status.SUCCESS, data: userCredential);
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<UserCredential>> reLogin() async {
    try {
      await auth.signOut();
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: currentLoggedInUserData.email!,
          password: currentLoginPassword);
      return Resource(Status.SUCCESS, data: userCredential);
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  void deleteFamily(String s) {
    db
        .collection('families')
        .doc(s)
        .delete()
        .then((value) => print('family deleted'));
  }

  void deleteTeacher(String s) {
    db
        .collection('teachers')
        .doc(s)
        .delete()
        .then((value) => print('teacher deleted'));
  }

  void deleteTeacherStudent(String teacherId, String studentId) {
    db
        .collection('teachers')
        .doc(teacherId)
        .collection("students")
        .doc(studentId)
        .delete()
        .then((value) => print('Student deleted'));
  }

  void deleteNotifications(String s) {
    db
        .collection('notifications')
        .doc(s)
        .delete()
        .then((value) => print('notification deleted'));
  }

  void deleteCategory(String id) {
    db
        .collection('categories')
        .doc(id)
        .delete()
        .then((value) => print('ad deleted'));
  }

  Stream<QuerySnapshot> getMessages(String currentUserId) {
    return db
        .collection('support_messages')
        .doc(currentUserId)
        .collection('messages')
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> getDashboardStatistics() {
    return db.collection('statistics').doc('dashboard').snapshots();
  }

  Stream<QuerySnapshot> getMessagesHeads() {
    return db
        .collection('support_messages')
        .orderBy('created_at', descending: false)
        .snapshots();
  }

  void deletePromocode(String s) {
    db
        .collection('promo_code')
        .doc(s)
        .delete()
        .then((value) => print('ad deleted'));
  }

  Future<Resource<bool>> checkIfPromoCodeExists(String promoCodeId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> promocodeResponse =
          await db.collection('promo_code').doc(promoCodeId).get();
      if (promocodeResponse.exists) {
        return Resource(Status.SUCCESS, data: true);
      } else {
        return Resource(Status.SUCCESS, data: false);
      }
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  void updateCustomerStatus(String id, String status) {
    db
        .collection('users')
        .doc(id)
        .update({"status": status}).then((value) => print('customer updated'));
  }

  Future<Resource<List<TeacherModel>>> getSystemUsers() async {
    List<TeacherModel> systemUsers = [];
    try {
      await db.collection("system_users").get().then((value) {
        value.docs.forEach((element) {
          systemUsers.add(TeacherModel.fromJson(element.data()));
        });
      });
      return Resource(Status.SUCCESS, data: systemUsers);
    } on FirebaseAuthException catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<int>> getCustomerOrdersCount(id) async {
    var count = 0;
    try {
      await db
          .collection('orders')
          .where("id", isEqualTo: id)
          .get()
          .then((value) {
        count = value.docs.length;
      });
      return Resource(Status.SUCCESS, data: count);
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  void deleteUser(TeacherModel systemUser) async {
    db
        .collection("system_users")
        .doc(systemUser.id)
        .delete()
        .then((value) => print('deleted'));
  }

  Future<Resource<UserCredential>> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Resource(Status.SUCCESS, data: userCredential);
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  void assignWorkerToOrder(String workerID, String orderId) {
    db.collection('orders').doc(orderId).update(
      {"worker_id": workerID, "assigned": true, "accepted": true},
    ).then(
      (value) => db.collection("workers").doc(workerID).update(
        {"has_order": true},
      ).then(
        (value) => print('assigned'),
      ),
    );
  }

  void setToken(String token) {
    print('adminTokecn ${token}');
    db.collection("admin_tokens").doc(token).set(
      {"token": token},
    ).then(
      (value) => print('token_uploaded'),
    );
  }

  void deleteCancelMessage(String s) {
    db
        .collection('cancel_reasons')
        .doc(s)
        .delete()
        .then((value) => print('ad deleted'));
  }
}
