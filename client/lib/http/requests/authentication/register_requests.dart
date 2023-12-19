import 'package:hyper_tools/http/requests/post_request.dart';
import 'package:hyper_tools/http/routes.dart';
import 'package:hyper_tools/models/authentication_model.dart';

class PostRegister extends PostRequest<AuthenticationModel> {
  PostRegister({required this.email, required this.password});
  final String email;
  final String password;

  @override
  Map<String, dynamic> get body =>
      <String, dynamic>{'email': email, 'password': password};

  @override
  AuthenticationModel builder(Map<String, dynamic> json) =>
      AuthenticationModel.fromJson(json);

  @override
  Uri get uri => Routes.register;

  @override
  bool get private => false;
}
