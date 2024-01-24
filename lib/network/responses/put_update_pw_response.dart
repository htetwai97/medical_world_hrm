class PutUpdatePasswordResponse {
  bool? success;
  String? newPassword;
  bool? error;
  String? message;

  PutUpdatePasswordResponse(
      {this.success, this.newPassword, this.error, this.message});

  PutUpdatePasswordResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    newPassword = json['newPassword'];
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['newPassword'] = this.newPassword;
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}