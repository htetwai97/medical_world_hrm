import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/connection_test_service/scaffold_with_connection_status.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model_impl.dart';
import 'package:hrm_medical_world_app_two/data/vo/user_data_vo.dart';
import 'package:hrm_medical_world_app_two/view/employee/widgets/drawer_property_list_view.dart';
import 'package:hrm_medical_world_app_two/view/attendance/screen/attendance_screen.dart';
import 'package:hrm_medical_world_app_two/view/employee/widgets/employee_choice_row_view.dart';
import 'package:hrm_medical_world_app_two/view/employee/widgets/header_employee_page_view.dart';
import 'package:hrm_medical_world_app_two/view/leave/screen/leave_screen.dart';
import 'package:hrm_medical_world_app_two/view/logout_loading/screen/logout_loading_screen.dart';
import 'package:hrm_medical_world_app_two/view/outside_office_roll_call/screen/outside_office_roll_call_screen.dart';
import 'package:hrm_medical_world_app_two/view/payslip/screen/payslip_screen.dart';
import 'package:hrm_medical_world_app_two/view/profile/screen/profile_screen.dart';
import 'package:hrm_medical_world_app_two/view/real_time_payroll/screen/realtime_payroll_screen.dart';
import 'package:hrm_medical_world_app_two/view/reset_password/screen/reset_password_screen.dart';
import 'package:hrm_medical_world_app_two/view/roll_call_medical/screen/roll_call_medical_screen.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  UserDataVO? userDataVO;
  bool isLoading = false;

  HRMRepoModel hrmRepoModel = HRMRepoModelImpl();

  void _onTapLogOut(BuildContext context) {
    Functions.logoutDialog(context, 100, () {
      Navigator.pop(context);
    }, () {
      Functions.replacementTransition(context, const LogoutLoadingScreen());
    }, "Are you Sure?", "You will be logout from the application.", "Cancel",
        "OK");
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    hrmRepoModel.getEmployeeData().then((employeeData) {
      userDataVO = employeeData.user;
      isLoading = false;
      setState(() {});
    }).onError((error, stackTrace) {
      Functions.toast(msg: "Dio Employee data error", status: false);
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return ScaffoldWithConnectionStatus(
      child: SafeArea(
        child: (isLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                key: scaffoldKey,
                drawer: Drawer(
                  backgroundColor: MATERIAL_COLOR,
                  width: scaleWidth(context) / 1.4,
                  child: DrawerPropertyListView(
                    onTapLogOut: () {
                      _onTapLogOut(context);
                    },
                    onTapMyInfo: () {
                      Functions.replacementTransition(
                          context, const ResetPasswordScreen());
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      HeaderEmployeePageView(
                        scaffoldKey: scaffoldKey,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            EmployeeChoiceRowView(
                              titleOne: "Profile",
                              titleTwo: "Your Attendance",
                              imageOne: "assets/images/hr_profile.png",
                              imageTwo: "assets/images/hr_attendance.png",
                              onTapOne: () {
                                Functions.transition(
                                    context, const ProfileScreen());
                              },
                              onTapTwo: () {
                                Functions.transition(
                                    context, const AttendanceScreen());
                              },
                            ),
                            const SizedBox(height: 20),
                            EmployeeChoiceRowView(
                              titleOne: "Leave",
                              titleTwo: "Roll Call",
                              imageOne: "assets/images/hr_leave_image_jpeg.jpg",
                              imageTwo: "assets/images/hrm_roll_call.png",
                              onTapOne: () {
                                Functions.transition(
                                    context, const LeaveScreen());
                              },
                              onTapTwo: () {
                                Functions.logoutDialog(context, 220, () {
                                  Functions.replacementTransition(
                                    context,
                                    RollCallMedicalScreen(
                                      userDataVO: userDataVO,
                                    ),
                                  );
                                }, () {
                                  Functions.replacementTransition(
                                    context,
                                    const OutsideOfficeRollCallScreen(),
                                  );
                                },
                                    "Select Location",
                                    "Assign Your Attendance From",
                                    "Office",
                                    "Outdoor");
                              },
                            ),
                            const SizedBox(height: 20),
                            EmployeeChoiceRowView(
                              titleOne: "PaySlip",
                              titleTwo: "Real Time Payroll",
                              imageOne: "assets/images/hr_payslip.jpg",
                              imageTwo: "assets/images/hr_realtimepayment.png",
                              onTapOne: () {
                                Functions.transition(
                                    context, const PayslipScreen());
                              },
                              onTapTwo: () {
                                Functions.transition(
                                    context, const RealTimePayRollScreen());
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
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
