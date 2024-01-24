import 'package:hrm_medical_world_app_two/data/vo/attendance_id_vo.dart';

class GetAlreadyAttendancesResponse {
  bool? success;
  List<AttendanceIdVO>? data;

  GetAlreadyAttendancesResponse({this.success, this.data});

  GetAlreadyAttendancesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AttendanceIdVO>[];
      json['data'].forEach((v) {
        data!.add(new AttendanceIdVO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
