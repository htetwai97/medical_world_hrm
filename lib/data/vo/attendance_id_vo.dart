class AttendanceIdVO {
  String? sId;
  String? clockIn;
  String? clockOut;
  String? report;
  String? attachFile;

  AttendanceIdVO({
    this.sId,
    this.clockIn,
    this.clockOut,
    this.report,
    this.attachFile,
  });

  AttendanceIdVO.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clockIn = json['clockIn'];
    clockOut = json['clockOut'];
    report = json['report'];
    attachFile = json['attachFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['clockIn'] = this.clockIn;
    data['clockOut'] = this.clockOut;
    data['report'] = this.report;
    data['attachFile'] = this.attachFile;
    return data;
  }
}
