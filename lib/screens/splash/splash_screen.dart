import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alekhlas_teachers/screens/splash/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:alekhlas_teachers/utils/colors.dart';

import '../base_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen<SplashViewModel>(
      onModelReady: (splashViewModel) {
        splashViewModel.checkLogin();
      },
      builder: (context, splashViewModel, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: primaryColor,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/images/Rahwan-logo.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
