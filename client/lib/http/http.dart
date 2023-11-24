import "dart:async";
import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;

import "../models/error.model.dart";
import "../models/success.model.dart";

class Http {
  static String? _accessToken;
  static set accessToken(String value) => _accessToken = value;

  static Map<String, String> _header({bool private = true}) {
    if (private == true && _accessToken == null)
      throw Exception("Access token not found");

    return {
      "content-type": "application/json",
      if (private) "Authorization": _accessToken!,
    };
  }

  static Future<T> _request<T>({
    required Future<http.Response> Function() query,
    required T Function(Map<String, dynamic> data) onSuccess,
  }) async {
    try {
      final http.Response response = await query();
      final int statusCode = response.statusCode;
      final Map<String, dynamic> body = jsonDecode(response.body);

      // request sent success
      if (statusCode >= 200 && statusCode < 300) {
        SuccessModel success = SuccessModel.fromJson(body);
        return onSuccess(success.data);
      }

      // request sent error
      ErrorModel error = ErrorModel.fromJson(body);
      return Future.error(error);
    }
    // request timeout
    on TimeoutException catch (_) {
      return Future.error(
        ErrorModel(errorMessage: "La requête a pris trop de temps"),
      );
    }
    // server offline
    on SocketException catch (_) {
      return Future.error(ErrorModel(errorMessage: "Serveur inaccessible"));
    }
    // other exception
    catch (_) {
      return Future.error(ErrorModel(errorMessage: "Erreur non categorisée"));
    }
  }

  static Future<T> get<T>(
    Uri uri,
    T Function(Map<String, dynamic> data) onSuccess, {
    bool private = true,
  }) =>
      _request(
        query: () => http.get(uri, headers: _header(private: private)),
        onSuccess: onSuccess,
      );

  static Future<T> post<T>(
    Uri uri,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic> data) onSuccess, {
    bool private = true,
  }) =>
      _request(
        query: () => http.post(
          uri,
          headers: _header(private: private),
          body: jsonEncode(body),
        ),
        onSuccess: onSuccess,
      );
}
