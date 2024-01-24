// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
// import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
// import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
// import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
// import 'package:hrm_medical_world_app_two/view/appointment_detail/bloc/appointment_detail_bloc.dart';
// import 'package:hrm_medical_world_app_two/view/appointment_detail/widgets/about_customer_widget.dart';
// import 'package:hrm_medical_world_app_two/view/appointment_detail/widgets/check_in_check_out_toggle_widget.dart';
// import 'package:hrm_medical_world_app_two/view/appointment_detail/widgets/detail_header_widget.dart';
// import 'package:hrm_medical_world_app_two/view/bottom_navigation/screen/bottom_navigation_screen.dart';
// import 'package:hrm_medical_world_app_two/view/leave/widgets/attach_file_section_view.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';
//
// class AppointmentDetailScreen extends StatelessWidget {
//   final String appointmentId;
//   const AppointmentDetailScreen({
//     Key? key,
//     required this.appointmentId,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AppointmentDetailBloc(appointmentId),
//       child: Selector<AppointmentDetailBloc, bool>(
//         selector: (context, bloc) => bloc.isLoading,
//         builder: (context, isLoading, child) => (isLoading)
//             ? Container(
//                 color: MATERIAL_COLOR,
//                 child: const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               )
//             : Selector<AppointmentDetailBloc, bool>(
//                 selector: (context, bloc) => bloc.inAppLoading,
//                 builder: (context, isInAppLoading, child) => Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Scaffold(
//                       body: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Consumer<AppointmentDetailBloc>(
//                               builder: (context, bloc, child) =>
//                                   DetailHeaderWidget(
//                                     onPress: (){
//                                       Navigator.pop(context);
//                                     },
//                                 customerName:
//                                     bloc.appointmentVO?.customerName ?? "",
//                                 date: bloc.appointmentVO?.date
//                                         ?.substring(0, 10) ??
//                                     "",
//                                 time: bloc.appointmentVO?.time ?? "",
//                                 phone:
//                                     bloc.appointmentVO?.phone?.toString() ?? "",
//                                 address: bloc.appointmentVO?.address ?? "",
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Consumer<AppointmentDetailBloc>(
//                               builder: (context, bloc, child) =>
//                                   AboutCustomerWidget(
//                                 customerName:
//                                     bloc.appointmentVO?.customerName ?? "",
//                                 description:
//                                     bloc.appointmentVO?.description ?? "",
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Consumer<AppointmentDetailBloc>(
//                               builder: (context, bloc, child) =>
//                                   CheckInCheckOutToggleWidget(
//                                 iconData: MdiIcons.clockIn,
//                                 name: "Check In",
//                                 upDateSwitchValue:
//                                     bloc.appointmentVO?.isCheckIn ?? false,
//                                 onSwitchToggle: (value) {
//                                   if (bloc.inAppLoading == false) {
//                                     if (bloc.appointmentVO?.isCheckIn ==
//                                             false ||
//                                         bloc.appointmentVO?.isCheckIn == null) {
//                                       bloc.onCheckIn();
//                                     } else {
//                                       Functions.toast(
//                                           msg: "Already Checked In!",
//                                           status: true);
//                                     }
//                                   }
//                                 },
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Consumer<AppointmentDetailBloc>(
//                               builder: (context, bloc, child) =>
//                                   CheckInCheckOutToggleWidget(
//                                 iconData: MdiIcons.clockOut,
//                                 name: "Check Out",
//                                 upDateSwitchValue:
//                                     bloc.appointmentVO?.isCheckOut ?? false,
//                                 onSwitchToggle: (value) {
//                                   if (bloc.inAppLoading == false) {
//                                     if (bloc.appointmentVO?.isCheckOut ==
//                                             false ||
//                                         bloc.appointmentVO?.isCheckOut ==
//                                             null) {
//                                       bloc.onCheckOut();
//                                     } else {
//                                       Functions.toast(
//                                           msg: "Already Checked Out!",
//                                           status: true);
//                                     }
//                                   }
//                                 },
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               child: Text(
//                                 "Report",
//                                 style: ConfigStyle.boldStyleThree(
//                                   18,
//                                   BLACK_HEAVY,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               child: Consumer<AppointmentDetailBloc>(
//                                 builder: (context, bloc, child) => TextField(
//                                   maxLines: 1,
//                                   controller: bloc.textEditingController,
//                                   decoration: const InputDecoration(
//                                     hintText: "Enter report",
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 30),
//                             Consumer<AppointmentDetailBloc>(
//                               builder: (context, bloc, child) =>
//                                   AttachFileSectionView(
//                                 textStyle: ConfigStyle.boldStyleThree(
//                                   DIMEN_EIGHTEEN,
//                                   BLACK_HEAVY,
//                                 ),
//                                 fileName: bloc.fileName?.substring(0, 22) ?? "",
//                                 onChooseFile: () async {
//                                   var result =
//                                       await FilePicker.platform.pickFiles(
//                                     type: FileType.image,
//                                     allowMultiple: false,
//                                   );
//                                   var platFormFile = result?.files.first;
//                                   if (platFormFile != null) {
//                                     bloc.onPickedAttachFile(
//                                       File(platFormFile.path ?? ""),
//                                     );
//                                   }
//                                 },
//                               ),
//                             ),
//                             const SizedBox(height: 40),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Consumer<AppointmentDetailBloc>(
//                                 builder: (context, bloc, child) =>
//                                     MaterialButton(
//                                   onPressed: () {
//                                     if (bloc.inAppLoading == false) {
//                                       bloc.onTapSubmit().then((value) {
//                                         Functions.replacementTransition(context,
//                                             const BottomNavigationScreen());
//                                       });
//                                     }
//                                   },
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 40, vertical: 10),
//                                   color: APP_THEME_COLOR,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Text(
//                                     "Submit",
//                                     style: ConfigStyle.regularStyleThree(
//                                       14,
//                                       MATERIAL_COLOR,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isInAppLoading,
//                       child: const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }
