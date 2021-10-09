import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:alekhlas_teachers/screens/home/model/stattistics_model.dart';
import 'package:alekhlas_teachers/screens/home/viewmodel/home_view_model.dart';
import 'package:alekhlas_teachers/screens/home/widgets/card.dart';

import '../../base_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BaseScreen<HomeViewModel>(
      onModelReady: (viewModel) {},
      builder: (context, viewModel, _) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
              ],
            ),
          ),
        ),
      ),
    );
  }
}