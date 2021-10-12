import 'package:alekhlas_teachers/screens/base_screen.dart';
import 'package:alekhlas_teachers/screens/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen<HomeViewModel>(
      onModelReady: (viewModel) {},
      builder: (context, viewModel, _) => Scaffold(
        body: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {

            },
            child: Icon(Icons.add),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
