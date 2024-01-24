import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model_impl.dart';
import 'package:hrm_medical_world_app_two/network/responses/post_login_response.dart';
import 'package:hrm_medical_world_app_two/persistence/share_preference/share_preference_key_constants.dart';
import 'package:hrm_medical_world_app_two/view/bottom_navigation/screen/bottom_navigation_screen.dart';
import 'package:hrm_medical_world_app_two/view/employee/screen/employee_screen.dart';
import 'package:hrm_medical_world_app_two/view/onboarding/screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  HRMRepoModel hrmRepoModel = HRMRepoModelImpl();
  PostLoginResponse? postLoginResponse;

  Future _autoLogin(String email, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    await hrmRepoModel.postUserLogin(email, password).then((response) {
      postLoginResponse = response;
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
    if (postLoginResponse != null) {
      Functions.toast(msg: "Auto Login success", status: true);
      return Future.value();
    } else {
      return Future.error("e");
    }
  }

  @override
  void initState() {
    super.initState();
    hrmRepoModel.getString(EMAIL).then((email) {
      hrmRepoModel.getString(PASSWORD).then((password) {
        _autoLogin(email, password).then((response) {
          Functions.replacementTransition(
              context, const EmployeeScreen());
        }).onError((error, stackTrace) {
          Functions.replacementTransition(context, const OnboardScreen());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MATERIAL_COLOR,
      body: Center(
        child: Image.asset(
          "assets/images/medical_world_logo.jpg",
          width: scaleWidth(context) - 50,
        ),
      ),
    );
  }
}
