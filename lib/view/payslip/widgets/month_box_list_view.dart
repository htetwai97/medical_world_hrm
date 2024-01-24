import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/data/vo/month_for_pay_slip_vo.dart';
import 'package:hrm_medical_world_app_two/view/payslip/widgets/payslip_month_box_view.dart';

class MonthBoxListView extends StatefulWidget {
  final Function(String) onTapMonth;
  const MonthBoxListView({
    super.key,
    required this.onTapMonth,
  });

  @override
  State<MonthBoxListView> createState() => _MonthBoxListViewState();
}

class _MonthBoxListViewState extends State<MonthBoxListView> {
  List<MonthForPaySlipVO> monthMap = [
    MonthForPaySlipVO(month: "Jan", isSelected: false),
    MonthForPaySlipVO(month: "Feb", isSelected: false),
    MonthForPaySlipVO(month: "March", isSelected: false),
    MonthForPaySlipVO(month: "April", isSelected: false),
    MonthForPaySlipVO(month: "May", isSelected: false),
    MonthForPaySlipVO(month: "June", isSelected: false),
    MonthForPaySlipVO(month: "July", isSelected: false),
    MonthForPaySlipVO(month: "Aug", isSelected: false),
    MonthForPaySlipVO(month: "Sep", isSelected: false),
    MonthForPaySlipVO(month: "Oct", isSelected: false),
    MonthForPaySlipVO(month: "Nov", isSelected: false),
    MonthForPaySlipVO(month: "Dec", isSelected: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: monthMap.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return PaySlipMonthBoxView(
            boxColor:
                monthMap[index].isSelected ? APP_THEME_COLOR : Colors.white,
            textColor:
                monthMap[index].isSelected ? MATERIAL_COLOR : BLACK_HEAVY,
            month: monthMap[index].month,
            year: DateTime.now().year.toString(),
            onTap: () {
              for (int i = 0; i < monthMap.length; i++) {
                monthMap[i].isSelected = false;
              }
              monthMap[index].isSelected = true;
              widget.onTapMonth(monthMap[index].month);
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
