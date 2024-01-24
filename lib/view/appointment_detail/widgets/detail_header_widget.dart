import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
import 'package:hrm_medical_world_app_two/view/appointment_detail/widgets/date_and_time_row_widget.dart';

class DetailHeaderWidget extends StatelessWidget {
  final String customerName, date, time, phone, address;
  final bool enableBack;
  final Function onPress;
  const DetailHeaderWidget({
    super.key,
    required this.customerName,
    required this.date,
    required this.time,
    required this.phone,
    required this.address,
    this.enableBack = true,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(234, 248, 251, 1),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Visibility(
            visible: enableBack,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    onPress();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: BLACK_HEAVY,
                    size: 30,
                  )),
            ),
          ),
          const Icon(
            Icons.person,
            size: 60,
            color: APP_THEME_COLOR,
          ),
          const SizedBox(height: 20),
          Text(
            customerName,
            style: ConfigStyle.boldStyleOne(20, BLACK_HEAVY),
          ),
          const SizedBox(height: 20),
          DateAndTimeRowWidget(
            date: date,
            time: time,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: BLACK_HEAVY,
                      size: 24,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      phone,
                      style: ConfigStyle.regularStyleThree(
                        14,
                        BLACK_HEAVY,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.home,
                      color: BLACK_HEAVY,
                      size: 24,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      address,
                      style: ConfigStyle.regularStyleThree(
                        14,
                        BLACK_HEAVY,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
