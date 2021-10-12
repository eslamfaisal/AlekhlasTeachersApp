import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:alekhlas_teachers/enums/screen_state.dart';
import 'package:alekhlas_teachers/models/resources.dart';
import 'package:alekhlas_teachers/models/status.dart';
import 'package:alekhlas_teachers/routs/routs_names.dart';
import 'package:alekhlas_teachers/screens/base_view_model.dart';
import 'package:alekhlas_teachers/screens/login/model/teacher_model.dart';
import 'package:alekhlas_teachers/services/firebase_services.dart';
import 'package:alekhlas_teachers/services/navigation_service.dart';
import 'package:alekhlas_teachers/services/shared_pref_services.dart';
import 'package:alekhlas_teachers/utils/constants.dart';
import 'package:alekhlas_teachers/utils/shared_preferences_constants.dart';

import '../../../locator.dart';

class LoginViewModel extends BaseViewModel {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var _firebaseServices = locator<FirebaseServices>();

  Future<Resource<String>> login() async {
    try{
      currentLoginPassword = passwordController.value.text;
      setState(ViewState.Busy);
      Resource<UserCredential>? response = await _firebaseServices.login(
          emailController.value.text.trim(), passwordController.value.text);
      if (response.status == Status.ERROR) {
        setState(ViewState.Idle);
        return Resource(Status.ERROR, errorMessage: response.errorMessage);
      } else {
        print(response.data!.user!.uid);
        Resource<TeacherModel> userDataResponse = await _firebaseServices
            .getSystemUserProfile(response.data!.user!.uid);

        print(userDataResponse.data!.email);
        if (response.status == Status.ERROR) {
          setState(ViewState.Idle);
          return Resource(Status.ERROR, errorMessage: response.errorMessage);
        } else {
          currentLoggedInUserData = userDataResponse.data!;
          return Resource(Status.SUCCESS, errorMessage: response.errorMessage);
        }
      }
    }catch(e){
      print("eslamss = ${e.toString()}");
      setState(ViewState.Idle);
      return Resource(Status.ERROR, errorMessage:e.toString());
    }

  }

  FormFieldValidator<String>? emailValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('please_enter_your_email');
      }
      if (!isValidEmail(value.trim())) {
        return tr('please_enter_your_valid_email');
      }

      return null;
    };

    return validator;
  }

  bool isValidEmail(String email) {
    bool emailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
    return emailValid;
  }

  FormFieldValidator<String>? passwordValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('please_enter_your_password');
      }
      if (value.length < 6) {
        return tr('password_more_6_chars');
      }
      return null;
    };
    return validator;
  }
}
