class AuthenticationModel {
  AuthenticationModel({required this.accessToken});

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationModel(accessToken: json['accessToken']);

  final String accessToken;
}
