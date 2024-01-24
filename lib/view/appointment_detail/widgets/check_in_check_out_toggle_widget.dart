import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CheckInCheckOutToggleWidget extends StatelessWidget {
  final IconData iconData;
  final bool upDateSwitchValue;
  final String name;
  final Function(bool) onSwitchToggle;
  const CheckInCheckOutToggleWidget({
    super.key,
    required this.iconData,
    required this.upDateSwitchValue,
    required this.name,
    required this.onSwitchToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: BLACK_HEAVY,
          ),
          const SizedBox(width: 20),
          Text(
            name,
            style: ConfigStyle.regularStyleThree(
              14,
              BLACK_HEAVY,
            ),
          ),
          const Spacer(),
          Switch(
            value: upDateSwitchValue,
            onChanged: (bool newValue) {
              onSwitchToggle(newValue);
            },
          ),
        ],
      ),
    );
  }
}
