class AuthenticationModel {
  final String accessToken;

  AuthenticationModel({required this.accessToken});

  factory AuthenticationModel.fromJson(json) =>
      AuthenticationModel(accessToken: json["accessToken"]);
}
