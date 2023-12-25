class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'],
        email: json['email'],
        name: json['name'],
      );

  final String id;
  final String email;
  final String name;
}
