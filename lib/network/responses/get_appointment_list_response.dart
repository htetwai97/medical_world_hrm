import 'package:hrm_medical_world_app_two/data/vo/appointment_vo.dart';

class GetAppointmentListResponse {
  bool? success;
  List<AppointmentVO>? data;

  GetAppointmentListResponse({this.success, this.data});

  GetAppointmentListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AppointmentVO>[];
      json['data'].forEach((v) {
        data!.add(new AppointmentVO.fromJson(v));
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
