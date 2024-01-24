import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/connection_test_service/scaffold_with_connection_status.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:hrm_medical_world_app_two/view/bottom_navigation/screen/bottom_navigation_screen.dart';
import 'package:hrm_medical_world_app_two/view/employee/screen/employee_screen.dart';
import 'package:hrm_medical_world_app_two/view/login/widgets/password_text_field.dart';
import 'package:hrm_medical_world_app_two/view/logout_loading/screen/logout_loading_screen.dart';
import 'package:hrm_medical_world_app_two/view/onboarding/widgets/button_elevated_view.dart';
import 'package:hrm_medical_world_app_two/view/reset_password/bloc/reset_password_bloc.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithConnectionStatus(
      child: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => ResetPasswordBloc(),
          child: Stack(
            children: [
              Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Consumer<ResetPasswordBloc>(
                  builder: (context, bloc, child) => Visibility(
                    visible: bloc.isFABVisible,
                    child: ButtonElevatedView(
                      title: "Reset",
                      onTap: () {
                        bloc.onTapReset().then((value) {
                          Functions.replacementTransition(
                              context, const EmployeeScreen());
                        });
                      },
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Functions.replacementTransition(
                                    context, const EmployeeScreen());
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                size: 30,
                                color: BLACK_HEAVY,
                              ),
                            ),
                            const SizedBox(width: 60),
                            Text(
                              "Reset Password",
                              style: ConfigStyle.regularStyleThree(
                                24,
                                BLACK_HEAVY,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Create your new password of the App for security reason",
                          style: ConfigStyle.regularStyleThree(
                            18,
                            BLACK_HEAVY,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Consumer<ResetPasswordBloc>(
                        builder: (context, bloc, child) => Form(
                          key: bloc.oldPasswordFormKey,
                          child: PasswordTextFieldWidget(
                            focusNode: bloc.oldFocusNode,
                            title: "Verify Old Password",
                            hint: "Enter old password",
                            isObscure: bloc.isObscureOld,
                            passwordController: bloc.oldPasswordController,
                            onPressedVisibleIcon: () {
                              bloc.onTapVisibilityOld();
                            },
                            onChanged: () {
                              bloc.oldPWValidate();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Consumer<ResetPasswordBloc>(
                        builder: (context, bloc, child) => Form(
                          key: bloc.createPasswordFormKey,
                          child: PasswordTextFieldWidget(
                            focusNode: bloc.createFocusNode,
                            title: "Create New Password",
                            hint: "Enter new password",
                            isObscure: bloc.isObscureCreate,
                            passwordController: bloc.createPasswordController,
                            onPressedVisibleIcon: () {
                              bloc.onTapVisibilityCreate();
                            },
                            onChanged: () {
                              bloc.createPWValidate();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Consumer<ResetPasswordBloc>(
                        builder: (context, bloc, child) => Form(
                          key: bloc.confPasswordFromKey,
                          child: PasswordTextFieldWidget(
                            focusNode: bloc.confirmFocusNode,
                            title: "Confirm New Password",
                            hint: "Enter new password",
                            isObscure: bloc.isObscureConfirm,
                            passwordController: bloc.confPasswordController,
                            onPressedVisibleIcon: () {
                              bloc.onTapVisibilityConfirm();
                            },
                            onChanged: () {
                              bloc.confirmPWValidate();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              Consumer<ResetPasswordBloc>(
                builder: (context, bloc, child) => Visibility(
                  visible: bloc.isLoading,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: LOGIN_BUTTON_COLOR,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
