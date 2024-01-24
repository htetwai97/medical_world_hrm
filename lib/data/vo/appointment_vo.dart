class AppointmentVO {
  String? sId;
  bool? isDeleted;
  String? createdAt;
  String? date;
  String? time;
  String? customerName;
  String? address;
  int? phone;
  double? latitude;
  double? longitude;
  String? description;
  String? report;
  bool? status;
  bool? isCheckIn;
  bool? isCheckOut;
  String? checkInTime;
  String? checkOutTime;
  String? attachFile;
  int? iV;

  AppointmentVO({
    this.sId,
    this.isDeleted,
    this.createdAt,
    this.date,
    this.time,
    this.customerName,
    this.address,
    this.phone,
    this.latitude,
    this.longitude,
    this.description,
    this.report,
    this.status,
    this.attachFile,
    this.iV,
    this.isCheckIn,
    this.isCheckOut,
    this.checkInTime,
    this.checkOutTime,
  });

  AppointmentVO.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    date = json['date'];
    time = json['time'];
    customerName = json['customerName'];
    address = json['address'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    report = json['report'];
    status = json['status'];
    attachFile = json['attachFile'];
    isCheckIn = json['checkIn'];
    isCheckOut = json['checkOut'];
    checkInTime = json['checkInTime'];
    checkOutTime = json[''];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['date'] = this.date;
    data['time'] = this.time;
    data['customerName'] = this.customerName;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['description'] = this.description;
    data['report'] = this.report;
    data['status'] = this.status;
    data['attachFile'] = this.attachFile;
    data['__v'] = this.iV;
    data['checkIn'] = this.isCheckIn;
    data['checkOut'] = this.isCheckOut;
    data['checkInTime'] = this.checkInTime;
    data[''] = this.checkOutTime;
    return data;
  }
}
