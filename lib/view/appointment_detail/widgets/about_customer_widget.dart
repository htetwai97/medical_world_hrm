import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';

class AboutCustomerWidget extends StatelessWidget {
  final String customerName, description;
  const AboutCustomerWidget({
    super.key,
    required this.customerName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About $customerName",
            style: ConfigStyle.boldStyleThree(
              18,
              BLACK_HEAVY,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: ConfigStyle.regularStyleThree(
              14,
              BLACK_HEAVY,
            ),
          ),
        ],
      ),
    );
  }
}
