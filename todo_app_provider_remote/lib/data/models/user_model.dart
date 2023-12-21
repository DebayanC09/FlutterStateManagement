import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity{

  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']?.toString();
    name = json['name']?.toString();
    email = json['email']?.toString();
    token = json['token']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    return data;
  }


}
