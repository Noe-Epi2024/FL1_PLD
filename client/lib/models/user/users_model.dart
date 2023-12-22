import 'package:hyper_tools/models/user/user_model.dart';

class UsersModel {
  UsersModel({required this.users});

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        users: List<Map<String, dynamic>>.from(json['users'])
            .map(UserModel.fromJson)
            .toList(),
      );

  final List<UserModel> users;
}
