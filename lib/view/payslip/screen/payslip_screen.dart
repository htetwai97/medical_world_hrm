import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/connection_test_service/scaffold_with_connection_status.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_color.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';
import 'package:hrm_medical_world_app_two/view/payslip/bloc/payslip_bloc.dart';
import 'package:hrm_medical_world_app_two/view/payslip/widgets/download_button_view.dart';
import 'package:hrm_medical_world_app_two/view/payslip/widgets/month_box_list_view.dart';
import 'package:hrm_medical_world_app_two/view/payslip/widgets/pdf_payslip_view.dart';
import 'package:hrm_medical_world_app_two/view/payslip/widgets/widget_pdf_data_view.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class PayslipScreen extends StatelessWidget {
  const PayslipScreen({Key? key}) : super(key: key);

  Future<void> _printDoc(
      String month,
      String employeeName,
      String entitleSalary,
      String mealAllowance,
      String travelAllowance,
      String incentive,
      String bonus,
      String overtime,
      String subtotal,
      String tax,
      String total) async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(
              month,
              employeeName,
              entitleSalary,
              mealAllowance,
              travelAllowance,
              incentive,
              bonus,
              overtime,
              subtotal,
              tax,
              total);
        },
      ),
    );
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithConnectionStatus(
      child: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => PayslipBloc(),
          child: Scaffold(
            backgroundColor: MATERIAL_COLOR,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: APP_THEME_COLOR,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: MATERIAL_COLOR,
                ),
              ),
              title: Text(
                "Payslip",
                style: ConfigStyle.boldStyleThree(
                  DIMEN_TWENTY_TWO,
                  MATERIAL_COLOR,
                ),
              ),
            ),
            body: Selector<PayslipBloc, bool>(
                builder: (context, isLoading, child) {
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Consumer<PayslipBloc>(
                            builder: (context, bloc, child) => MonthBoxListView(
                              onTapMonth: (month) {
                                bloc.onTapMonth(month);
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          Consumer<PayslipBloc>(
                            builder: (context, bloc, child) =>
                                (bloc.paySlipList.length == 0)
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 60),
                                        child: Image.asset(
                                          "assets/images/salary-slip.jpg",
                                          width: 300,
                                          height: 300,
                                        ),
                                      )
                                    : WidgetPdfDataView(
                                        entitleSalary: bloc
                                                .paySlipData?.entitledSalary
                                                .toString() ??
                                            "",
                                        mealAllowance: bloc
                                                .paySlipData?.maTotalAmount
                                                .toString() ??
                                            "",
                                        travelAllowance: bloc
                                                .paySlipData?.travelTotalAmount
                                                .toString() ??
                                            "",
                                        incentive: bloc
                                                .paySlipData?.incentiveAmount
                                                .toString() ??
                                            "",
                                        bonus: bloc.paySlipData?.bonusAmount
                                                .toString() ??
                                            "",
                                        overtime: bloc
                                                .paySlipData?.otTotalAmount
                                                .toString() ??
                                            "",
                                        subtotal: bloc.paySlipData?.subTotal
                                                .toString() ??
                                            "",
                                        tax: bloc.paySlipData?.incomeTaxAmount
                                                .toString() ??
                                            "",
                                        total: bloc.paySlipData?.netSalary
                                                .toString() ??
                                            "",
                                      ),
                          ),
                          const SizedBox(height: 40),
                          Consumer<PayslipBloc>(
                            builder: (context, bloc, child) =>
                                (bloc.paySlipList.length == 0)
                                    ? Text(
                                        "No payslip for that month",
                                        style: ConfigStyle.regularStyleTwo(
                                          16,
                                          BLACK_HEAVY,
                                        ),
                                      )
                                    : DownloadButtonView(
                                        onTap: () {
                                          _printDoc(
                                              bloc.month,
                                              bloc.userDataVO?.givenName ?? "",
                                              bloc.paySlipData?.entitledSalary
                                                      .toString() ??
                                                  "",
                                              bloc.paySlipData?.maTotalAmount
                                                      .toString() ??
                                                  "",
                                              bloc.paySlipData
                                                      ?.travelTotalAmount
                                                      .toString() ??
                                                  "",
                                              bloc.paySlipData?.incentiveAmount
                                                      .toString() ??
                                                  "",
                                              bloc.paySlipData?.bonusAmount
                                                      .toString() ??
                                                  "",
                                              bloc.paySlipData?.otTotalAmount
                                                      .toString() ??
                                                  "",
                                              bloc.paySlipData?.subTotal.toString() ??
                                                  "",
                                              bloc.paySlipData?.incomeTaxAmount
                                                      .toString() ??
                                                  "",
                                              bloc.paySlipData?.netSalary
                                                      .toString() ??
                                                  "");
                                        },
                                      ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  }
                },
                selector: (context, bloc) => bloc.isLoading),
          ),
        ),
      ),
    );
  }
}
