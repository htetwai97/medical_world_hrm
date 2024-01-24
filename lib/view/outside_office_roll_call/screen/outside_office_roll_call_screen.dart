import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:hrm_medical_world_app_two/data/vo/user_data_vo.dart';
import 'package:hrm_medical_world_app_two/view/appointment_detail/widgets/check_in_check_out_toggle_widget.dart';
import 'package:hrm_medical_world_app_two/view/appointment_detail/widgets/detail_header_widget.dart';
import 'package:hrm_medical_world_app_two/view/employee/screen/employee_screen.dart';
import 'package:hrm_medical_world_app_two/view/leave/widgets/attach_file_section_view.dart';
import 'package:hrm_medical_world_app_two/view/outside_office_roll_call/bloc/outside_office_roll_call_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class OutsideOfficeRollCallScreen extends StatelessWidget {
  const OutsideOfficeRollCallScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OutsideOfficeRollCallBloc(),
      child: Selector<OutsideOfficeRollCallBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => (isLoading)
            ? Container(
                color: MATERIAL_COLOR,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Selector<OutsideOfficeRollCallBloc, bool>(
                selector: (context, bloc) => bloc.inAppLoading,
                builder: (context, isInAppLoading, child) => Stack(
                  alignment: Alignment.center,
                  children: [
                    SafeArea(
                      child: Scaffold(
                        body: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<OutsideOfficeRollCallBloc, UserDataVO?>(
                                selector: (context, bloc) => bloc.userDataVO,
                                builder: (context, user, child) =>
                                    DetailHeaderWidget(
                                  enableBack: true,
                                  customerName: user?.givenName ?? "",
                                  date: DateTime.now()
                                      .toString()
                                      .substring(0, 11),
                                  time: DateTime.now()
                                      .toString()
                                      .substring(11, 16),
                                  phone: user?.phone ?? "",
                                  address: user?.address ?? "",
                                  onPress: () {
                                    Functions.replacementTransition(
                                        context, const EmployeeScreen());
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Consumer<OutsideOfficeRollCallBloc>(
                                builder: (context, bloc, child) =>
                                    CheckInCheckOutToggleWidget(
                                  iconData: MdiIcons.clockIn,
                                  name: "Check In",
                                  upDateSwitchValue: bloc.clockIn != null &&
                                      bloc.clockIn != "",
                                  onSwitchToggle: (value) {
                                    if (bloc.inAppLoading == false) {
                                      if (!(bloc.clockIn != null &&
                                          bloc.clockIn != "")) {
                                        bloc.onCheckIn();
                                      } else {
                                        Functions.toast(
                                            msg: "Already Check In",
                                            status: false);
                                      }
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Consumer<OutsideOfficeRollCallBloc>(
                                builder: (context, bloc, child) =>
                                    CheckInCheckOutToggleWidget(
                                  iconData: MdiIcons.clockOut,
                                  name: "Check Out",
                                  upDateSwitchValue: bloc.clockOut != null &&
                                      bloc.clockOut != "",
                                  onSwitchToggle: (value) {
                                    if (bloc.inAppLoading == false) {
                                      if (bloc.clockIn != null &&
                                          bloc.clockIn != "") {
                                        if (!(bloc.clockOut != null &&
                                            bloc.clockOut != "")) {
                                          bloc.onCheckOut();
                                        } else {
                                          Functions.toast(
                                              msg: "Already Check Out",
                                              status: false);
                                        }
                                      } else {
                                        Functions.toast(
                                            msg: "Check In first",
                                            status: false);
                                      }
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "Report",
                                  style: ConfigStyle.boldStyleThree(
                                    18,
                                    BLACK_HEAVY,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Selector<OutsideOfficeRollCallBloc,
                                    TextEditingController>(
                                  selector: (context, bloc) =>
                                      bloc.textEditingController,
                                  builder: (context, controller, child) =>
                                      TextField(
                                    maxLines: 1,
                                    controller: controller,
                                    decoration: const InputDecoration(
                                      hintText: "Enter report",
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Consumer<OutsideOfficeRollCallBloc>(
                                builder: (context, bloc, child) =>
                                    AttachFileSectionView(
                                  textStyle: ConfigStyle.boldStyleThree(
                                    DIMEN_EIGHTEEN,
                                    BLACK_HEAVY,
                                  ),
                                  fileName: (bloc.fileName != null &&
                                          bloc.fileName!.length >= 22)
                                      ? bloc.fileName!.substring(0, 22)
                                      : "",
                                  onChooseFile: () async {
                                    var result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                      allowMultiple: false,
                                    );
                                    var platFormFile = result?.files.first;
                                    if (platFormFile != null) {
                                      bloc.onPickedAttachFile(
                                        File(platFormFile.path ?? ""),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 40),
                              Align(
                                alignment: Alignment.center,
                                child: Consumer<OutsideOfficeRollCallBloc>(
                                  builder: (context, bloc, child) =>
                                      MaterialButton(
                                    onPressed: () {
                                      if (bloc.inAppLoading == false) {
                                        bloc.onTapSubmit().then((value) {
                                          Functions.replacementTransition(
                                              context, const EmployeeScreen());
                                        });
                                      }
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    color: APP_THEME_COLOR,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Submit",
                                      style: ConfigStyle.regularStyleThree(
                                        14,
                                        MATERIAL_COLOR,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isInAppLoading,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
