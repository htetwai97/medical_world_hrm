// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
// import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
// import 'package:hrm_medical_world_app_two/view/appointment_list/screen/appointment_list_screen.dart';
// import 'package:hrm_medical_world_app_two/view/employee/screen/employee_screen.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//
// class BottomNavigationScreen extends StatefulWidget {
//   final int currentIndex;
//   const BottomNavigationScreen({
//     super.key,
//     this.currentIndex = 0,
//   });
//
//   @override
//   State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
// }
//
// class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
//   late int currentIndex;
//
//   List<GButton> gList = const [
//     GButton(
//       haptic: true,
//       icon: Icons.person,
//       text: "Me",
//     ),
//     GButton(
//       haptic: true,
//       icon: MdiIcons.newspaper,
//       text: "Appointments",
//     ),
//   ];
//
//   List<Widget> screens = const [
//     EmployeeScreen(),
//     AppointmentListScreen(),
//   ];
//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.currentIndex;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: IndexedStack(
//         index: currentIndex,
//         children: screens,
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: MATERIAL_COLOR,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(14),
//             topRight: Radius.circular(14),
//           ),
//           boxShadow: [
//             Functions.buildBoxShadow(),
//           ],
//           border: Border.all(color: BLACK_LIGHT, width: 0.2),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//           child: GNav(
//             onTabChange: (index) {
//               setState(() {
//                 currentIndex = index;
//               });
//             },
//             selectedIndex: currentIndex,
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//             gap: 8,
//             color: BLACK_HEAVY,
//             activeColor: MATERIAL_COLOR,
//             backgroundColor: Colors.transparent,
//             tabBackgroundColor: APP_THEME_COLOR,
//             tabs: gList,
//           ),
//         ),
//       ),
//     );
//   }
// }
