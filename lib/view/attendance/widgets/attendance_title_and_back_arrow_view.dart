import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';

class AttendanceTitleAndBackArrowView extends StatelessWidget {
  final Function onTapBack;
  final String title;
  const AttendanceTitleAndBackArrowView({
    super.key,
    required this.onTapBack,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            onTapBack();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        SizedBox(width: scaleWidth(context) / 10),
        Text(
          title,
          style: ConfigStyle.boldStyleTwo(
            DIMEN_TWENTY_TWO,
            BLACK_HEAVY,
          ),
        )
      ],
    );
  }
}
