import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';

class BackAndEditButtonRowView extends StatelessWidget {
  final Function onTapBack;
  final Function onTapEdit;
  const BackAndEditButtonRowView({
    super.key,
    required this.onTapBack,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            onTapBack();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: DIMEN_TWENTY_FOUR,
            color: BLACK_HEAVY,
          ),
        ),
        IconButton(
          onPressed: () {
            onTapEdit();
          },
          icon: const Icon(
            Icons.edit,
            size: DIMEN_TWENTY_FOUR,
            color: BLACK_HEAVY,
          ),
        ),
      ],
    );
  }
}
