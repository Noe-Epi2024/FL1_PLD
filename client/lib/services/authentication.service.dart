import "../http/http.dart";
import "../http/routes.dart";
import "../models/authentication.model.dart";

class AuthenticationService {
  static Future<AuthenticationModel> login(String email, String password) =>
      Http.post(
        Routes.login,
        {"email": email, "password": password},
        (data) => AuthenticationModel.fromJson(data),
        private: false,
      );

  static Future<AuthenticationModel> register(
    String email,
    String password,
  ) =>
      Http.post(
        Routes.register,
        {"email": email, "password": password},
        (data) => AuthenticationModel.fromJson(data),
        private: false,
      );
}
