import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

buildPrintableData(
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
        String total) =>
    pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Align(
            alignment: pw.Alignment.topCenter,
            child: pw.Text(
              "Medical World co.ltd",
              style: pw.TextStyle(
                fontSize: DIMEN_TWENTY_FOUR + 2,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Align(
            alignment: pw.Alignment.topCenter,
            child: pw.Text(
              "$month Payslip For $employeeName",
              style: const pw.TextStyle(
                fontSize: DIMEN_TWENTY_TWO,
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            "(+)Earning",
            style: const pw.TextStyle(
              fontSize: DIMEN_TWENTY_FOUR,
              color: PdfColors.green,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Entitled Salary",
                style: const pw.TextStyle(
                  fontSize: DIMEN_TWENTY_FOUR,
                ),
              ),
              pw.Text(
                entitleSalary,
                style: pw.TextStyle(
                  color: const PdfColor(0.5, 0.34, 0.63, 1),
                  fontSize: DIMEN_TWENTY_FOUR,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Meal allowance",
                style: const pw.TextStyle(
                  fontSize: DIMEN_TWENTY_FOUR,
                ),
              ),
              pw.Text(
                mealAllowance,
                style: pw.TextStyle(
                  color: const PdfColor(0.5, 0.34, 0.63, 1),
                  fontSize: DIMEN_TWENTY_FOUR,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Travel allowance",
                style: const pw.TextStyle(
                  fontSize: DIMEN_TWENTY_FOUR,
                ),
              ),
              pw.Text(
                travelAllowance,
                style: pw.TextStyle(
                  color: const PdfColor(0.5, 0.34, 0.63, 1),
                  fontSize: DIMEN_TWENTY_FOUR,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Incentive",
                style: const pw.TextStyle(
                  fontSize: DIMEN_TWENTY_FOUR,
                ),
              ),
              pw.Text(
                incentive,
                style: pw.TextStyle(
                  color: const PdfColor(0.5, 0.34, 0.63, 1),
                  fontSize: DIMEN_TWENTY_FOUR,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Bonus",
                style: const pw.TextStyle(
                  fontSize: DIMEN_TWENTY_FOUR,
                ),
              ),
              pw.Text(
                bonus,
                style: pw.TextStyle(
                  color: const PdfColor(0.5, 0.34, 0.63, 1),
                  fontSize: DIMEN_TWENTY_FOUR,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Overtime",
                style: const pw.TextStyle(
                  fontSize: DIMEN_TWENTY_FOUR,
                ),
              ),
              pw.Text(
                overtime,
                style: pw.TextStyle(
                  color: const PdfColor(0.5, 0.34, 0.63, 1),
                  fontSize: DIMEN_TWENTY_FOUR,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Subtotal",
                style: const pw.TextStyle(
                  fontSize: DIMEN_TWENTY_FOUR,
                ),
              ),
              pw.Text(
                subtotal,
                style: pw.TextStyle(
                  color: const PdfColor(0.5, 0.34, 0.63, 1),
                  fontSize: DIMEN_TWENTY_FOUR,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.SizedBox(
            height: 40,
            child: pw.Center(
              child: pw.Container(
                height: 0.8,
                color: PdfColors.black,
              ),
            ),
          ),
          pw.Text(
            "(-)Deduction",
            style: const pw.TextStyle(
              fontSize: DIMEN_TWENTY_FOUR,
              color: PdfColors.red,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Tax",
                style: const pw.TextStyle(
                  fontSize: DIMEN_TWENTY_FOUR,
                ),
              ),
              pw.Text(
                tax,
                style: pw.TextStyle(
                  color: const PdfColor(0.5, 0.34, 0.63, 1),
                  fontSize: DIMEN_TWENTY_FOUR,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.SizedBox(
            height: 40,
            child: pw.Center(
              child: pw.Container(
                height: 0.8,
                color: PdfColors.black,
              ),
            ),
          ),
          pw.Text(
            "Final",
            style: const pw.TextStyle(
              fontSize: DIMEN_TWENTY_FOUR,
              color: PdfColors.blue,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Total",
                style: const pw.TextStyle(
                  fontSize: DIMEN_TWENTY_FOUR,
                ),
              ),
              pw.Text(
                total,
                style: pw.TextStyle(
                  color: const PdfColor(0.5, 0.34, 0.63, 1),
                  fontSize: DIMEN_TWENTY_FOUR,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          // pw.SizedBox(height: 40),
          // pw.Align(
          //   alignment: pw.Alignment.bottomRight,
          //   child: pw.Column(
          //     children: [
          //       pw.Text(
          //         "Approved by",
          //         style: const pw.TextStyle(
          //           fontSize: DIMEN_TWENTY_FOUR,
          //         ),
          //       ),
          //       pw.Text(
          //         "Ma Thandar",
          //         style: const pw.TextStyle(
          //           color: PdfColor(0.5, 0.34, 0.63, 1),
          //           fontSize: DIMEN_TWENTY_TWO,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
