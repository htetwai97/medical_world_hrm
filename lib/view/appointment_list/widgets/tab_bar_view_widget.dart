import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
import 'package:hrm_medical_world_app_two/core/core_functions/functions.dart';

class TabBarViewWidget extends StatelessWidget {
  final String name;
  final Function onTap;
  final bool isSelected;
  const TabBarViewWidget({
    super.key,
    required this.name,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            Functions.buildBoxShadow(),
          ],
          color: (isSelected == true) ? APP_THEME_COLOR : MATERIAL_COLOR,
        ),
        child: Text(
          name,
          style: ConfigStyle.regularStyleThree(
            DIMEN_FOURTEEN,
            (isSelected == true) ? MATERIAL_COLOR : APP_THEME_COLOR,
          ),
        ),
      ),
    );
  }
}
