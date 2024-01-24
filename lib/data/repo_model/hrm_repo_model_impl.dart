import 'dart:io';
import 'package:dio/src/form_data.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model.dart';
import 'package:hrm_medical_world_app_two/data/vo/leave_code_vo.dart';
import 'package:hrm_medical_world_app_two/network/data_agent/dio_data_agent_impl.dart';
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
import 'package:hrm_medical_world_app_two/persistence/share_preference/share_preference.dart';

class HRMRepoModelImpl extends HRMRepoModel {
  HRMRepoModelImpl._internal();

  static final HRMRepoModelImpl _singleton = HRMRepoModelImpl._internal();

  factory HRMRepoModelImpl() => _singleton;

  final _dataAgent = DioDataAgentImpl();
  final _sharePreference = SharePreferenceModel();

  @override
  Future<String> getString(String key) {
    return _sharePreference.getString(key);
  }

  @override
  Future<void> saveString(String key, String value) {
    return _sharePreference.saveString(key, value);
  }

  @override
  Future<PostLoginResponse> postUserLogin(String email, String password) {
    return _dataAgent.postUserLogin(email, password);
  }

  @override
  Future<GetEmployeeDataResponse> getEmployeeData() {
    return _dataAgent.getEmployeeData();
  }

  @override
  Future<void> putUserDataUpdate(FormData formData) {
    return _dataAgent.putUserDataUpdate(formData);
  }

  @override
  Future<void> postLeaveFormCreate(FormData formData) {
    return _dataAgent.postLeaveFormCreate(formData);
  }

  @override
  Future<LeaveCodeVO> getLeaveCode() {
    return _dataAgent.getLeaveCode();
  }

  @override
  Future<GetAttendancePercentResponse> getMonthlyAttendance() {
    return _dataAgent.getMonthlyAttendance();
  }

  @override
  Future<PostEmployeeLeavesAndDateDetailResponse>
      postEmployeeLeavesAndDateDetails(String employeeId, String month) {
    return _dataAgent.postEmployeeLeavesAndDateDetails(employeeId, month);
  }

  @override
  Future<GetAssignmentResponse> getAppointment() {
    return _dataAgent.getAppointment();
  }

  @override
  Future<void> checkInAppointment(String appointmentID, String attendanceId) {
    return _dataAgent.checkInAppointment(appointmentID, attendanceId);
  }

  @override
  Future<void> checkOutAppointment(String appointmentID) {
    return _dataAgent.checkOutAppointment(appointmentID);
  }

  @override
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
  ) {
    return _dataAgent.reportMarketing(
      contactPerson,
      contactPersonPhone,
      followupDate,
      currentApp,
      currentDetail,
      requirement,
      request,
      budget,
      timeline,
      appointmentID,
      attach,
    );
  }

  @override
  Future<PostRealTimePayRollResponse> postRealTimePayRoll(
      String employeeId, String depId, String month, int basicSalary) {
    return _dataAgent.postRealTimePayRoll(
        employeeId, depId, month, basicSalary);
  }

  @override
  Future<PostHRMCheckInCheckOutResponse> postHrmCheckIn(
      String employeeId,
      String departmentId,
      String clockIn,
      String date,
      double targetLat,
      double targetLan,
      double? referenceLat,
      double? referenceLon) {
    return _dataAgent.postHrmCheckIn(employeeId, departmentId, clockIn, date,
        targetLat, targetLan, referenceLat, referenceLon);
  }

  @override
  Future<PostHRMCheckInCheckOutResponse> postHrmCheckOut(
      String clockOut,
      String attendanceId,
      double targetLat,
      double targetLan,
      double? referenceLat,
      double? referenceLon) {
    return _dataAgent.postHrmCheckOut(clockOut, attendanceId, targetLat,
        targetLan, referenceLat, referenceLon);
  }

  @override
  Future<GetPaySlipResponse> getPaySlip(String month) {
    return _dataAgent.getPaySlip(month);
  }

  @override
  Future<bool> clearAllSharePrefItems() {
    return _sharePreference.clearAllSharePrefItems();
  }

  @override
  Future<void> removeSharePrefItem(String key) {
    return _sharePreference.removeSharePrefItem(key);
  }

  @override
  Future<PutUpdatePasswordResponse> updatePassword(
      String email, String password) {
    return _dataAgent.updatePassword(email, password);
  }

  @override
  Future<GetAppointmentListResponse> getAppointments() {
    return _dataAgent.getAppointments();
  }

  @override
  Future<void> putAppointmentCheckIn(String appointmentId, String checkInHour) {
    return _dataAgent.putAppointmentCheckIn(appointmentId, checkInHour);
  }

  @override
  Future<void> putAppointmentCheckOut(
      String appointmentId, String checkOutHour) {
    return _dataAgent.putAppointmentCheckOut(appointmentId, checkOutHour);
  }

  @override
  Future<void> putAppointmentReport(
      String appointmentId, String report, FormData formData) {
    return _dataAgent.putAppointmentReport(appointmentId, report, formData);
  }

  @override
  Future<GetSingleAppointmentResponse> getSingleAppointment(
      String appointmentId) {
    return _dataAgent.getSingleAppointment(appointmentId);
  }

  @override
  Future<PostHRMCheckInCheckOutResponse> postHrmCheckInOutside(
      bool outsideOffice,
      String employeeId,
      String departmentId,
      String clockIn,
      String date,
      double targetLat,
      double targetLan) {
    return _dataAgent.postHrmCheckInOutside(outsideOffice, employeeId,
        departmentId, clockIn, date, targetLat, targetLan);
  }

  @override
  Future<PostHRMCheckInCheckOutResponse> postHrmCheckOutOutside(
      bool? outsideOffice,
      String clockOut,
      String? report,
      String attendanceId,
      double? targetLat,
      double? targetLan,
      File? attachFile,
      String? fileName) {
    return _dataAgent.postHrmCheckOutOutside(outsideOffice, clockOut, report,
        attendanceId, targetLat, targetLan, attachFile, fileName);
  }

  @override
  Future<GetAlreadyAttendancesResponse> getAlreadyAttendanceList(String date) {
    return _dataAgent.getAlreadyAttendanceList(date);
  }
}
