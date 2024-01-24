class HrmCheckInCheckOutDataVO {
  bool? isDeleted;
  String? date;
  bool? isPaid;
  String? type;
  String? source;
  String? clockIn;
  String? clockOut;
  String? sId;
  String? createdAt;
  int? iV;

  HrmCheckInCheckOutDataVO(
      {this.isDeleted,
      this.date,
      this.isPaid,
      this.type,
      this.source,
      this.clockIn,
      this.clockOut,
      this.sId,
      this.createdAt,
      this.iV});

  HrmCheckInCheckOutDataVO.fromJson(Map<String, dynamic> json) {
    isDeleted = json['isDeleted'];
    date = json['date'];
    isPaid = json['isPaid'];
    type = json['type'];
    source = json['source'];
    clockIn = json['clockIn'];
    clockOut = json['clockOut'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDeleted'] = this.isDeleted;
    data['date'] = this.date;
    data['isPaid'] = this.isPaid;
    data['type'] = this.type;
    data['source'] = this.source;
    data['clockIn'] = this.clockIn;
    data['clockOut'] = this.clockOut;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
