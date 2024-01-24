import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model_impl.dart';
import 'package:hrm_medical_world_app_two/data/vo/user_data_vo.dart';
import 'package:hrm_medical_world_app_two/view/logout_loading/screen/logout_loading_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileBloc extends ChangeNotifier {
  /// Bloc state
  bool isDisposed = false;

  /// Dependencies
  final HRMRepoModel _hrmRepoModel = HRMRepoModelImpl();

  /// Loading State
  bool isLoading = false;

  /// Screen states
  UserDataVO? userDataVO;

  ProfileBloc() {
    _showLoading();
    _hrmRepoModel.getEmployeeData().then((response) {
      userDataVO = response.user;
      _notifySafely();
      _hideLoading();
    });
  }

  void onTapLogOut(BuildContext context) {
    Functions.logoutDialog(context, 100, () {
      Navigator.pop(context);
    }, () {
      _hrmRepoModel.clearAllSharePrefItems().then((value) {
        if (value == true) {
          Functions.replacementTransition(context, const LogoutLoadingScreen());
        } else {
          Functions.toast(msg: "Logout failed", status: false);
        }
      });
    }, "Are you Sure?", "You will be logout from the application.", "Cancel",
        "OK");
  }

  void onTapLink(String url) {
    _launchUrl(url);
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Cannot launch url";
    }
  }

  /// loading situations
  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
