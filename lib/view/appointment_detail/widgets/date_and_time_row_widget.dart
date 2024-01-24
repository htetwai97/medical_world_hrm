import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';

class DateAndTimeRowWidget extends StatelessWidget {
  final String date, time;
  const DateAndTimeRowWidget({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: scaleWidth(context) / 2,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          color: APP_THEME_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_month,
                color: MATERIAL_COLOR,
                size: 24,
              ),
              const SizedBox(width: 20),
              Text(
                date,
                style: ConfigStyle.regularStyleThree(
                  14,
                  MATERIAL_COLOR,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: scaleWidth(context) / 2,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          color: APP_THEME_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_clock,
                color: MATERIAL_COLOR,
                size: 24,
              ),
              const SizedBox(width: 20),
              Text(
                time,
                style: ConfigStyle.regularStyleThree(
                  14,
                  MATERIAL_COLOR,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
