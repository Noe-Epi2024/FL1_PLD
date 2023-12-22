class MeModel {
  MeModel({
    required this.email,
    required this.name,
    required this.photo,
  });

  factory MeModel.fromJson(Map<String, dynamic> json) => MeModel(
        email: json['email'],
        name: json['name'],
        photo: json['photo'],
      );

  final String email;
  final String name;
  final String photo;
}
