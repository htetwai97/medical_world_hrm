import 'package:hrm_medical_world_app_two/data/vo/data_from_appointment_vo.dart';

class GetAssignmentResponse {
  List<DataFromAppointmentVO>? data;
  GetAssignmentResponse({this.data});

  GetAssignmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataFromAppointmentVO>[];
      json['data'].forEach((v) {
        data!.add(new DataFromAppointmentVO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
