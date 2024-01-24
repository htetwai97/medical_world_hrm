import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model_impl.dart';
import 'package:hrm_medical_world_app_two/persistence/share_preference/share_preference_key_constants.dart';
import 'package:hrm_medical_world_app_two/view/login/screen/login_screen.dart';

class LogoutLoadingScreen extends StatefulWidget {
  const LogoutLoadingScreen({Key? key}) : super(key: key);

  @override
  State<LogoutLoadingScreen> createState() => _LogoutLoadingScreenState();
}

class _LogoutLoadingScreenState extends State<LogoutLoadingScreen> {
  HRMRepoModel hrmRepoModel = HRMRepoModelImpl();
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
    ).then((value) {
      hrmRepoModel.removeSharePrefItem(PASSWORD).then((value) {
        hrmRepoModel.removeSharePrefItem(EMAIL).then((value) {
          Functions.replacementTransition(context, const LoginScreen());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LOGIN_BUTTON_COLOR,
        body: Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(
              children: [
                const SpinKitHourGlass(
                  duration: Duration(milliseconds: 5000),
                  color: CARD_FIRST_COLOR,
                ),
                const SizedBox(height: 20),
                Text(
                  "Logging out",
                  style: ConfigStyle.regularStyleOne(
                    20,
                    MATERIAL_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
