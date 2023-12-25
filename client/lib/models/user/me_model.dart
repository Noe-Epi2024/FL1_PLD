class MeModel {
  MeModel({required this.email, required this.name});

  factory MeModel.fromJson(Map<String, dynamic> json) =>
      MeModel(email: json['email'], name: json['name']);

  String email;
  String name;
}
