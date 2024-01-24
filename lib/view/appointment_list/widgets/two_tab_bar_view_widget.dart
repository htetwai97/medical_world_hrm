import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/view/appointment_list/widgets/tab_bar_view_widget.dart';

class TwoTabBarViewWidget extends StatelessWidget {
  final int index;
  final String tabOne, tabTwo;
  final Function onTapTabOne, onTapTabTwo;
  const TwoTabBarViewWidget({
    super.key,
    required this.tabOne,
    required this.tabTwo,
    required this.onTapTabOne,
    required this.onTapTabTwo,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TabBarViewWidget(
          name: tabOne,
          onTap: () {
            onTapTabOne();
          },
          isSelected: (index == 0),
        ),
        TabBarViewWidget(
          name: tabTwo,
          onTap: () {
            onTapTabTwo();
          },
          isSelected: (index == 1),
        ),
      ],
    );
  }
}
