import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hrm_medical_world_app_two/data/vo/leave_code_vo.dart';
import 'package:hrm_medical_world_app_two/network/responses/get_already_attendance_list_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/get_appointment_list_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/get_assignment_list_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/get_attendance_percent_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/get_payslip_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/get_single_appointment_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/get_userdata_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/post_employee_leaves_and_date_detail_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/post_hrm_checkin_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/post_login_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/post_real_time_payroll_response.dart';
import 'package:hrm_medical_world_app_two/network/responses/put_update_pw_response.dart';

abstract class DioDataAgent {
  Future<PostLoginResponse> postUserLogin(String email, String password);
  Future<GetEmployeeDataResponse> getEmployeeData();
  Future<void> putUserDataUpdate(FormData formData);
  Future<void> postLeaveFormCreate(FormData formData);
  Future<LeaveCodeVO> getLeaveCode();
  Future<GetAttendancePercentResponse> getMonthlyAttendance();
  Future<PostEmployeeLeavesAndDateDetailResponse>
      postEmployeeLeavesAndDateDetails(String employeeId, String month);
  Future<GetAssignmentResponse> getAppointment();
  Future<void> checkInAppointment(String appointmentID, String attendanceId);
  Future<void> checkOutAppointment(String appointmentID);
  Future<String> reportMarketing(
    String contactPerson,
    String contactPersonPhone,
    String followupDate,
    String currentApp,
    String currentDetail,
    String requirement,
    String request,
    String budget,
    String timeline,
    String appointmentID,
    File attach,
  );
  Future<PostRealTimePayRollResponse> postRealTimePayRoll(
      String employeeId, String depId, String month, int basicSalary);
  Future<PostHRMCheckInCheckOutResponse> postHrmCheckIn(
      String employeeId,
      String departmentId,
      String clockIn,
      String date,
      double targetLat,
      double targetLan,
      double? referenceLat,
      double? referenceLon);
  Future<PostHRMCheckInCheckOutResponse> postHrmCheckOut(
      String clockOut,
      String attendanceId,
      double targetLat,
      double targetLan,
      double? referenceLat,
      double? referenceLon);
  Future<GetPaySlipResponse> getPaySlip(String month);
  Future<PutUpdatePasswordResponse> updatePassword(
      String email, String password);
  Future<GetAppointmentListResponse> getAppointments();
  Future<void> putAppointmentCheckIn(String appointmentId, String checkInHour);
  Future<void> putAppointmentCheckOut(
      String appointmentId, String checkOutHour);
  Future<void> putAppointmentReport(
      String appointmentId, String report, FormData formData);
  Future<GetSingleAppointmentResponse> getSingleAppointment(
      String appointmentId);
  Future<PostHRMCheckInCheckOutResponse> postHrmCheckInOutside(
      bool outsideOffice,
      String employeeId,
      String departmentId,
      String clockIn,
      String date,
      double targetLat,
      double targetLan);
  Future<PostHRMCheckInCheckOutResponse> postHrmCheckOutOutside(
      bool? outsideOffice,
      String clockOut,
      String? report,
      String attendanceId,
      double? targetLat,
      double? targetLan,
      File? attachFile,
      String? fileName);
  Future<GetAlreadyAttendancesResponse> getAlreadyAttendanceList(String date);
}
