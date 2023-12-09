import "../../../models/authentication_model.dart";
import "../post_request.dart";
import "../../routes.dart";

class PostLogin extends PostRequest<AuthenticationModel> {
  final String email;
  final String password;

  PostLogin({required this.email, required this.password});

  @override
  Map<String, dynamic> get body => {"email": email, "password": password};

  @override
  AuthenticationModel builder(Map<String, dynamic> json) =>
      AuthenticationModel.fromJson(json);

  @override
  Uri get uri => Routes.login;

  @override
  bool get private => false;
}
