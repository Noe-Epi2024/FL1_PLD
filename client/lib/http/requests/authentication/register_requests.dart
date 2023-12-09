import "../../../models/authentication.model.dart";
import "../post_request.dart";
import "../../routes.dart";

class PostRegister extends PostRequest<AuthenticationModel> {
  final String email;
  final String password;

  PostRegister({required this.email, required this.password});

  @override
  Map<String, dynamic> get body => {"email": email, "password": password};

  @override
  AuthenticationModel builder(Map<String, dynamic> json) =>
      AuthenticationModel.fromJson(json);

  @override
  Uri get uri => Routes.register;

  @override
  bool get private => false;
}
