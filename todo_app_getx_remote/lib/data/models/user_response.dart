import 'user_model.dart';

class UserResponse {
  String? statusCode;
  String? message;
  String? status;
  UserModel? user;

  UserResponse({
    this.statusCode,
    this.message,
    this.status,
    this.user,
  });

  UserResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode']?.toString();
    message = json['message']?.toString();
    status = json['status']?.toString();
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['status'] = status;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    return data;
  }
}
