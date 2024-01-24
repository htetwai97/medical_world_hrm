import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
import 'package:hrm_medical_world_app_two/view/leave/widgets/drop_down_view.dart';

class YearChooseSectionView extends StatelessWidget {
  final String menuTitle;
  final String selectedItem;
  final Function(String) onChoose;
  const YearChooseSectionView({
    required this.onChoose,
    required this.menuTitle,
    required this.selectedItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Choose Year",
          style: ConfigStyle.boldStyleOne(
            DIMEN_SIXTEEN,
            BLACK_LIGHT,
          ),
        ),
        SizedBox(
          height: 50,
          width: 135,
          child: DropDownView(
            menuTitle: menuTitle,
            selectedValue: selectedItem,
            onChange: (value) {
              onChoose(value ?? "");
            },
          ),
        ),
      ],
    );
  }
}
