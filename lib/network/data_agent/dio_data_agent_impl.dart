import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hrm_medical_world_app_two/data/vo/leave_code_vo.dart';
import 'package:hrm_medical_world_app_two/network/api_service/api_constants.dart';
import 'package:hrm_medical_world_app_two/network/api_service/api_service.dart';
import 'package:hrm_medical_world_app_two/network/data_agent/dio_data_agent.dart';
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
import 'package:hrm_medical_world_app_two/persistence/share_preference/share_preference_key_constants.dart';
import 'package:http_parser/http_parser.dart';

class DioDataAgentImpl extends DioDataAgent {
  DioDataAgentImpl._internal();
  static final DioDataAgentImpl _singleton = DioDataAgentImpl._internal();
  factory DioDataAgentImpl() => _singleton;

  final SharePreferenceModel _sharePreferenceModel = SharePreferenceModel();

  @override
  Future<PostLoginResponse> postUserLogin(String email, String password) async {
    var data = {"email": email, "password": password};
    var dio = DioUtil.getDio(null);
    try {
      final response = await dio.post(LOGIN_URL, data: data);
      if (response.statusCode == 200) {
        await _sharePreferenceModel.saveString(TOKEN, response.data['token']);
        await _sharePreferenceModel.saveString(
            EMPLOYEE_ID, response.data['id']);
        await _sharePreferenceModel.saveString(
            GENDER, response.data['user']['gender']);

        return PostLoginResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<GetEmployeeDataResponse> getEmployeeData() async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var userId = await _sharePreferenceModel.getString(EMPLOYEE_ID);
    var dio = DioUtil.getDio(token);
    try {
      final response = await dio.get("$USER_DATA_URL/$userId");
      if (response.statusCode == 200) {
        return GetEmployeeDataResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> putUserDataUpdate(FormData formData) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    var data = formData;
    try {
      final response = await dio.put(USER_DATA_URL, data: data);
      if (response.statusCode == 200) {
        return Future.value();
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> postLeaveFormCreate(FormData formData) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    var data = formData;
    try {
      final response = await dio.post(LEAVE_URL, data: data);
      if (response.statusCode == 200) {
        return Future.value();
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<LeaveCodeVO> getLeaveCode() async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    try {
      final response = await dio.get(LEAVE_CODE_URL);
      if (response.statusCode == 200) {
        return LeaveCodeVO.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<GetAttendancePercentResponse> getMonthlyAttendance() async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var id = await _sharePreferenceModel.getString(EMPLOYEE_ID);
    var dio = DioUtil.getDio(token);
    dio.options.queryParameters = {"relatedEmployee": id};
    try {
      final response = await dio.get(ATTENDANCE_URL);
      if (response.statusCode == 200) {
        return GetAttendancePercentResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PostEmployeeLeavesAndDateDetailResponse>
      postEmployeeLeavesAndDateDetails(String employeeId, String month) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    var data = {'relatedEmployee': employeeId, 'month': month};
    try {
      final response = await dio.post(ATTENDANCE_URL, data: data);
      if (response.statusCode == 200) {
        return PostEmployeeLeavesAndDateDetailResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<GetAssignmentResponse> getAppointment() async {
    var id = await _sharePreferenceModel.getString(EMPLOYEE_ID);
    var dio = DioUtil.getDio(null);
    dio.options.queryParameters = {
      "accessKey": "crm-mobile-123@",
      "employee": id
    };
    try {
      final response = await dio.get(APPOINTMENT_URL);
      if (response.statusCode == 200) {
        return GetAssignmentResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> checkInAppointment(
      String appointmentID, String attendanceId) async {
    var dio = DioUtil.getDio(null);
    var data = {"accessKey": "crm-mobile-123@", "attendanceId": attendanceId};
    try {
      final response =
          await dio.put("$APPOINTMENT_URL/$appointmentID/check-in", data: data);
      if (response.statusCode == 200) {
        return Future.value();
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> checkOutAppointment(String appointmentID) async {
    var dio = DioUtil.getDio(null);
    var data = {
      "accessKey": "crm-mobile-123@",
    };
    try {
      final response = await dio
          .put("$APPOINTMENT_URL/$appointmentID/check-out", data: data);
      if (response.statusCode == 200) {
        return Future.value();
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
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
  ) async {
    var dio = DioUtil.getDio(null);
    var data = FormData.fromMap({
      'contactPerson': contactPerson,
      'contactPersonPhone': contactPersonPhone,
      'followUpDate': followupDate,
      'currentApp': currentApp,
      'currentDetail': currentDetail,
      'requirement': requirement,
      'request': request,
      'budget': budget,
      'timeline': timeline,
      'appointment': appointmentID,
      'accessKey': 'crm-mobile-123@',
      "attach": await MultipartFile.fromFile(
        attach.path,
        filename: attach.path.split('/').last,
        contentType: MediaType('image', 'png'),
      ),
    });
    try {
      final response = await dio.post(MARKET_REPORT_URL, data: data);
      if (response.statusCode == 201) {
        return Future.value("S");
      }
      return Future.error("E");
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PostRealTimePayRollResponse> postRealTimePayRoll(
      String employeeId, String depId, String month, int basicSalary) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    var data = {
      'dep': depId,
      'emp': employeeId,
      'month': month,
      'basicSalary': basicSalary
    };
    try {
      final response = await dio.post(REAL_TIME_PAYROLL_URL, data: data);
      if (response.statusCode == 200 || response.statusCode == 404) {
        return PostRealTimePayRollResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
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
      double? referenceLon) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    var data = {
      "targetLat": targetLat,
      "targetLon": targetLan,
      "referenceLat": referenceLat,
      "referenceLon": referenceLon,
      "relatedEmployee": employeeId,
      "relatedDepartment": departmentId,
      "clockIn": clockIn,
      "date": date,
    };
    try {
      final response = await dio.post(CHECKIN_URL_HRM, data: data);
      if (response.statusCode == 200) {
        return PostHRMCheckInCheckOutResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PostHRMCheckInCheckOutResponse> postHrmCheckInOutside(
      bool outsideOffice,
      String employeeId,
      String departmentId,
      String clockIn,
      String date,
      double targetLat,
      double targetLan) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    var data = {
      "outsideOffice": outsideOffice,
      "checkInLat": targetLat,
      "checkInLong": targetLan,
      "relatedEmployee": employeeId,
      "relatedDepartment": departmentId,
      "clockIn": clockIn,
      "date": date
    };
    try {
      final response = await dio.post(CHECKIN_URL_HRM, data: data);
      if (response.statusCode == 200) {
        return PostHRMCheckInCheckOutResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PostHRMCheckInCheckOutResponse> postHrmCheckOut(
      String clockOut,
      String attendanceId,
      double targetLat,
      double targetLan,
      double? referenceLat,
      double? referenceLon) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    var data = {
      "targetLat": targetLat,
      "targetLon": targetLan,
      "clockOut": clockOut,
      "attendaceID": attendanceId,
      "referenceLat": referenceLat,
      "referenceLon": referenceLon,
    };
    try {
      final response = await dio.put(CHECKIN_URL_HRM, data: data);
      if (response.statusCode == 200) {
        return PostHRMCheckInCheckOutResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
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
    String? fileName,
  ) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    late FormData data;
    if (attachFile != null) {
      data = FormData.fromMap({
        "attendaceID": attendanceId,
        "report": report,
        "outsideOffice": outsideOffice,
        "checkOutLat": targetLat,
        "checkOutLong": targetLan,
        "clockOut": clockOut,
        "reportFile": await MultipartFile.fromFile(
          attachFile.path ?? "",
          filename: fileName,
          contentType: MediaType('image', 'png'),
        ),
      });
    } else {
      data = FormData.fromMap({
        "attendaceID": attendanceId,
        "report": report,
        "outsideOffice": outsideOffice,
        "checkOutLat": targetLat,
        "checkOutLong": targetLan,
        "clockOut": clockOut,
      });
    }
    try {
      final response = await dio.put(CHECKIN_URL_HRM, data: data);
      if (response.statusCode == 200) {
        return PostHRMCheckInCheckOutResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<GetPaySlipResponse> getPaySlip(String month) async {
    var id = await _sharePreferenceModel.getString(EMPLOYEE_ID);
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    dio.options.queryParameters = {"month": month, "emp": id};
    try {
      final response = await dio.get(PAYSLIP_URL);
      if (response.statusCode == 200) {
        return GetPaySlipResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PutUpdatePasswordResponse> updatePassword(
      String email, String password) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    var data = {"email": email, "password": password};
    try {
      final response = await dio.put(UPDATE_PW_URL, data: data);
      if (response.statusCode == 200) {
        return PutUpdatePasswordResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<GetAppointmentListResponse> getAppointments() async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var id = await _sharePreferenceModel.getString(EMPLOYEE_ID);
    var dio = DioUtil.getDio(token);
    dio.options.queryParameters = {"relatedEmployee": id};
    try {
      final response = await dio.get(APPOINTMENT_LIST_URL);
      if (response.statusCode == 200) {
        return GetAppointmentListResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<GetSingleAppointmentResponse> getSingleAppointment(
      String appointmentId) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    try {
      final response = await dio.get("$APPOINTMENT_SINGLE_URL/$appointmentId");
      if (response.statusCode == 200) {
        return GetSingleAppointmentResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> putAppointmentCheckIn(
      String appointmentId, String checkInHour) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    var data = {"checkIn": checkInHour};
    try {
      final response =
          await dio.put("$APPOINTMENT_CHECKIN/$appointmentId", data: data);
      if (response.statusCode == 200) {
        return Future.value();
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> putAppointmentCheckOut(
      String appointmentId, String checkOutHour) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    var data = {"checkOut": checkOutHour};
    try {
      final response =
          await dio.put("$APPOINTMENT_CHECKOUT/$appointmentId", data: data);
      if (response.statusCode == 200) {
        return Future.value();
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> putAppointmentReport(
      String appointmentId, String report, FormData formData) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var dio = DioUtil.getDio(token);
    try {
      final response =
          await dio.put("$APPOINTMENT_REPORT/$appointmentId", data: formData);
      if (response.statusCode == 200) {
        return Future.value();
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<GetAlreadyAttendancesResponse> getAlreadyAttendanceList(
      String date) async {
    var token = await _sharePreferenceModel.getString(TOKEN);
    var id = await _sharePreferenceModel.getString(EMPLOYEE_ID);
    var dio = DioUtil.getDio(token);
    dio.options.queryParameters = {
      "relatedUser": id,
      "fromDate": date,
      "toDate": date
    };
    try {
      final response = await dio.get(ALREADY_ATTENDANCES_LIST_URL);
      if (response.statusCode == 200) {
        return GetAlreadyAttendancesResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
