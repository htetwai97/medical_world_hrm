import 'package:hrm_medical_world_app_two/data/vo/appointment_vo.dart';

class GetSingleAppointmentResponse {
  bool? success;
  AppointmentVO? data;

  GetSingleAppointmentResponse({this.success, this.data});

  GetSingleAppointmentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? new AppointmentVO.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
