class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'],
        email: json['email'],
        name: json['name'],
        photo: json['photo'],
      );

  final String id;
  final String email;
  final String name;
  final String photo;
}
