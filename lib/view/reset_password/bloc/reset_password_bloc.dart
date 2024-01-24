import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model_impl.dart';
import 'package:hrm_medical_world_app_two/network/responses/put_update_pw_response.dart';
import 'package:hrm_medical_world_app_two/persistence/share_preference/share_preference_key_constants.dart';

class ResetPasswordBloc extends ChangeNotifier {
  /// Bloc state
  bool isDisposed = false;

  /// Dependencies
  final HRMRepoModel _hrmRepoModel = HRMRepoModelImpl();

  /// Loading State
  bool isLoading = false;

  /// Screen states
  bool isObscureOld = true;
  bool isObscureCreate = true;
  bool isObscureConfirm = true;
  bool _isResetUnlock = false;
  TextEditingController oldPasswordController = TextEditingController();
  final oldPasswordFormKey = GlobalKey<FormState>();
  TextEditingController createPasswordController = TextEditingController();
  final createPasswordFormKey = GlobalKey<FormState>();
  TextEditingController confPasswordController = TextEditingController();
  final confPasswordFromKey = GlobalKey<FormState>();
  bool isOldPWV = false;
  bool isCreatePWV = false;
  bool isConfirmPWV = false;
  bool isFABVisible = true;
  bool isOldPWCorrect = false;
  bool isNewPWCorrect = false;
  String email = "";
  String oldPassword = "";
  FocusNode oldFocusNode = FocusNode();
  FocusNode createFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();
  PutUpdatePasswordResponse? response;

  ResetPasswordBloc() {
    _showLoading();
    oldFocusNode.addListener(_onOldFocusChange);
    createFocusNode.addListener(_onCreateFocusChange);
    confirmFocusNode.addListener(_onConfirmFocusChange);
    _hrmRepoModel.getString(EMAIL_FOR_RESET).then((email) {
      this.email = email;
      _notifySafely();
      _hrmRepoModel.getString(PASSWORD_FOR_RESET).then((oldPassword) {
        this.oldPassword = oldPassword;
        _notifySafely();
        _hideLoading();
      });
    });
  }

  void _onOldFocusChange() {
    isFABVisible = !oldFocusNode.hasFocus;
    _notifySafely();
  }

  void _onCreateFocusChange() {
    isFABVisible = !createFocusNode.hasFocus;
    _notifySafely();
  }

  void _onConfirmFocusChange() {
    isFABVisible = !confirmFocusNode.hasFocus;
    _notifySafely();
  }

  void onTapVisibilityOld() {
    isObscureOld = !isObscureOld;
    _notifySafely();
  }

  void onTapVisibilityCreate() {
    isObscureCreate = !isObscureCreate;
    _notifySafely();
  }

  void onTapVisibilityConfirm() {
    isObscureConfirm = !isObscureConfirm;
    _notifySafely();
  }

  void oldPWValidate() {
    isOldPWV = (oldPasswordFormKey.currentState?.validate() ?? false);
    _notifySafely();
    _validate();
  }

  void createPWValidate() {
    isCreatePWV = (createPasswordFormKey.currentState?.validate() ?? false);
    _notifySafely();
    _validate();
  }

  void confirmPWValidate() {
    isConfirmPWV = (confPasswordFromKey.currentState?.validate() ?? false);
    _notifySafely();
    _validate();
  }

  void _validate() {
    if (isOldPWV &&
        isCreatePWV &&
        isConfirmPWV &&
        (createPasswordController.text == confPasswordController.text) &&
        (oldPasswordController.text == oldPassword)) {
      _isResetUnlock = true;
      _notifySafely();
    } else {
      _isResetUnlock = false;
      _notifySafely();
    }
  }

  void _oldPWCheck() {
    if (oldPasswordController.text == "") {
      isOldPWCorrect = false;
      _notifySafely();
      Functions.toast(msg: "Old password is empty", status: false);
    } else {
      if (oldPasswordController.text != oldPassword) {
        isOldPWCorrect = false;
        _notifySafely();
        Functions.toast(msg: "Old password incorrect", status: false);
      } else {
        isOldPWCorrect = true;
        _notifySafely();
      }
    }
  }

  void _newPasswordCheck() {
    if (createPasswordController.text == "" ||
        confPasswordController.text == "") {
      isNewPWCorrect = false;
      _notifySafely();
      Functions.toast(msg: "New Password is empty", status: false);
    } else {
      if (createPasswordController.text != confPasswordController.text) {
        isNewPWCorrect = false;
        _notifySafely();
        Functions.toast(msg: "New password Confirmation wrong", status: false);
      } else {
        isNewPWCorrect = true;
        _notifySafely();
      }
    }
  }

  Future onTapReset() async {
    _validate();
    _showLoading();
    _oldPWCheck();
    _newPasswordCheck();
    if (_isResetUnlock) {
      await _hrmRepoModel
          .updatePassword(email, confPasswordController.text)
          .then((response) {
        this.response = response;
        _notifySafely();
      }).onError((error, stackTrace) {
        Functions.toast(msg: "update password failed", status: false);
      });
      if (response?.newPassword != null) {
        await _hrmRepoModel.saveString(PASSWORD, response?.newPassword ?? "");
        await Future.delayed(const Duration(seconds: 1));
        Functions.toast(msg: "Password update successfully", status: true);
        return Future.value();
      } else {
        _hideLoading();
        return Future.error("error");
      }
    } else {
      _hideLoading();
      return Future.error("error");
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
