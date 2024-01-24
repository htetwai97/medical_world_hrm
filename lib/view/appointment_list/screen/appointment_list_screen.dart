// import 'package:flutter/material.dart';
// import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
// import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
// import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
// import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
// import 'package:hrm_medical_world_app_two/data/vo/appointment_vo.dart';
// import 'package:hrm_medical_world_app_two/view/appointment_detail/screen/appointment_detail_screen.dart';
// import 'package:hrm_medical_world_app_two/view/appointment_list/bloc/appointment_list_bloc.dart';
// import 'package:hrm_medical_world_app_two/view/appointment_list/widgets/appointment_box_widget.dart';
// import 'package:hrm_medical_world_app_two/view/appointment_list/widgets/two_tab_bar_view_widget.dart';
// import 'package:provider/provider.dart';
//
// class AppointmentListScreen extends StatelessWidget {
//   const AppointmentListScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AppointmentListBloc(),
//       child: Scaffold(
//         backgroundColor: MATERIAL_COLOR,
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: MATERIAL_COLOR,
//           centerTitle: true,
//           title: Text(
//             "My Appointments",
//             style: ConfigStyle.regularStyleThree(
//               DIMEN_SIXTEEN,
//               BLACK_HEAVY,
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               Consumer<AppointmentListBloc>(
//                 builder: (context, bloc, child) => TwoTabBarViewWidget(
//                   index: bloc.index,
//                   tabOne: "Pending",
//                   tabTwo: "Complete",
//                   onTapTabOne: () {
//                     bloc.onChooseTap(0);
//                   },
//                   onTapTabTwo: () {
//                     bloc.onChooseTap(1);
//                   },
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Selector<AppointmentListBloc, bool>(
//                 selector: (context, bloc) => bloc.isLoading,
//                 builder: (context, isLoading, child) =>
//                     Selector<AppointmentListBloc, List<AppointmentVO>?>(
//                   selector: (context, bloc) => bloc.appointmentList,
//                   builder: (context, appointmentList, child) => (isLoading)
//                       ? const Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : (appointmentList?.length == 0)
//                           ? Center(
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     top: scaleHeight(context) / 3),
//                                 child: Text(
//                                   "There is no appointment!",
//                                   style: ConfigStyle.regularStyleThree(
//                                     DIMEN_SIXTEEN,
//                                     BLACK_HEAVY,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : ListView.separated(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.vertical,
//                               physics: const NeverScrollableScrollPhysics(),
//                               separatorBuilder: (c, i) => SizedBox(
//                                 height: 30,
//                                 child: Center(
//                                   child: Container(
//                                     height: 0.3,
//                                     color: BLACK_LIGHT,
//                                   ),
//                                 ),
//                               ),
//                               itemCount: appointmentList?.length ?? 0,
//                               itemBuilder: (c, i) {
//                                 var appointment = appointmentList?[i];
//                                 return AppointmentBoxWidget(
//                                   customerName: appointment?.customerName ?? "",
//                                   phone: appointment?.phone?.toString() ?? "",
//                                   date:
//                                       appointment?.date?.substring(0, 10) ?? "",
//                                   time: appointment?.time ?? "",
//                                   status: appointment?.status ?? false,
//                                   onTapDetail: () {
//                                     Functions.transition(
//                                       context,
//                                       AppointmentDetailScreen(
//                                         appointmentId: appointment?.sId ?? "",
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
