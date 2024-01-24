import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/view/employee/widgets/drawer_list_tile_section_view.dart';


class DrawerPropertyListView extends StatelessWidget {
  final Function onTapLogOut,onTapMyInfo;
  const DrawerPropertyListView({
    super.key,
    required this.onTapLogOut,
    required this.onTapMyInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: MATERIAL_COLOR,
          height: 168,
          width: double.infinity,
          child: Image.asset(
            "assets/images/medical_world_logo.jpg",
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: DIMEN_TWENTY),
        DrawerListTileSectionView(
          icon: Icons.key,
          text: "Credential",
          onTap: () {
            onTapMyInfo();
          },
        ),
        DrawerListTileSectionView(
          icon: Icons.logout,
          text: "Log out",
          onTap: () {
            onTapLogOut();
          },
        ),
      ],
    );
  }
}
