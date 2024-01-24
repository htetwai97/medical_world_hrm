import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppointmentBoxWidget extends StatelessWidget {
  final String customerName, phone, date, time;
  final Function onTapDetail;
  final bool status;
  const AppointmentBoxWidget({
    super.key,
    required this.customerName,
    required this.phone,
    required this.date,
    required this.time,
    required this.onTapDetail,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          Functions.buildBoxShadow(),
        ],
        color: MATERIAL_COLOR,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              const SizedBox(
                width: 30,
                child: Icon(
                  Icons.person,
                  color: APP_THEME_COLOR,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 120,
                child: Text(
                  customerName,
                  style: ConfigStyle.regularStyleThree(
                    14,
                    APP_THEME_COLOR,
                  ),
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 30,
                child: Icon(
                  Icons.phone,
                  color: APP_THEME_COLOR,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 120,
                child: Text(
                  phone,
                  style: ConfigStyle.regularStyleThree(
                    14,
                    APP_THEME_COLOR,
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              const SizedBox(
                width: 30,
                child: Icon(
                  MdiIcons.calendar,
                  size: 24,
                  color: BLACK_HEAVY,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 120,
                child: Text(
                  date,
                  style: ConfigStyle.regularStyleThree(
                    DIMEN_FOURTEEN,
                    BLACK_HEAVY,
                  ),
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 30,
                child: Icon(
                  MdiIcons.clockIn,
                  size: 24,
                  color: BLACK_HEAVY,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 120,
                child: Text(
                  time,
                  style: ConfigStyle.regularStyleThree(
                    DIMEN_FOURTEEN,
                    BLACK_HEAVY,
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              if (status == false) {
                onTapDetail();
              } else {
                Functions.toast(msg: "Appointment Complete", status: true);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color:
                    (status == false) ? APP_THEME_COLOR : Colors.grey.shade300,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(0),
                  bottom: Radius.circular(8),
                ),
              ),
              width: scaleWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Text(
                  (status == false) ? "Detail" : "Finished",
                  style: ConfigStyle.regularStyleThree(
                    14,
                    (status == false) ? MATERIAL_COLOR : BLACK_LIGHT,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
