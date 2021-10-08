import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:alekhlas_teachers/enums/screen_state.dart';
import 'package:alekhlas_teachers/models/resources.dart';
import 'package:alekhlas_teachers/models/status.dart';
import 'package:alekhlas_teachers/routs/routs_names.dart';
import 'package:alekhlas_teachers/screens/login/viewmodel/login_view_model.dart';
import 'package:alekhlas_teachers/services/firebase_services.dart';
import 'package:alekhlas_teachers/services/navigation_service.dart';
import 'package:alekhlas_teachers/utils/common_functions.dart';
import 'package:alekhlas_teachers/utils/extensions.dart';
import 'package:alekhlas_teachers/utils/texts.dart';
import 'package:alekhlas_teachers/widgets/StyledButton.dart';
import 'package:alekhlas_teachers/widgets/styled_text_field.dart';

import '../../../locator.dart';
import '../../base_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen<LoginViewModel>(
      onFinish: (){

      },
      onModelReady: (_) {
      },
      builder: (context, loginViewModel, child) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                width: 400,
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Center(
                    child: Form(
                      key: loginViewModel.formKey,
                      child: Column(
                        children: [
                          // SizedBox(
                          //   width: 300,
                          //   height: 300,
                          //   child: Image.asset('assets/images/welcomehome.png'),
                          // ),
                          headerText(
                            tr('login'),
                          ),
                          heightSpace(16),
                          StyledTextField(
                            controller: loginViewModel.emailController,
                            hint: tr('email'),
                            validator: loginViewModel.emailValidator(),
                          ),
                          heightSpace(8),
                          StyledTextField(
                            controller: loginViewModel.passwordController,
                            hint: tr('password'),
                            validator: loginViewModel.passwordValidator(),
                            isPassword: true,
                          ),
                          heightSpace(24),
                          loginViewModel.state == ViewState.Busy
                              ? Center(child: CircularProgressIndicator())
                              : StyledButton(tr("login")).onTap(() async {
                                  Resource<String> response =
                                      await loginViewModel.login();

                                  if (response.status == Status.ERROR) {
                                    final snackBar = SnackBar(
                                        content:
                                            Text(tr(response.errorMessage!)));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    locator<NavigationService>()
                                        .navigateToAndClearStack(
                                            RouteName.HOME);
                                  }
                                }),
                          heightSpace(16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
