import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:hrm_medical_world_app_two/view/roll_call_medical/screen/roll_call_medical_screen.dart';

class HeaderEmployeePageView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HeaderEmployeePageView({
    super.key,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          height: scaleHeight(context) / 4,
          width: scaleWidth(context),
          decoration: BoxDecoration(
            color: APP_THEME_COLOR,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(70),
              bottomRight: Radius.circular(70),
            ),
            boxShadow: [
              Functions.buildBoxShadow(),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundImage:
                    AssetImage("assets/images/medical_world_logo.jpg"),
              ),
              // Image.asset(
              //   "assets/images/medical_world_logo.jpg",
              //   width: 80,
              //   fit: BoxFit.fill,
              // ),
              const SizedBox(
                width: DIMEN_FOURTEEN,
              ),
              Text(
                "HR Management System",
                style: ConfigStyle.regularStyleOne(
                  DIMEN_SIXTEEN,
                  MATERIAL_COLOR,
                ),
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: MATERIAL_COLOR,
            size: 30,
          ),
        ),
      ],
    );
  }
}
