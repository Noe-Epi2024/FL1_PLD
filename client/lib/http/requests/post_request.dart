import "dart:async";

import "package:flutter/material.dart";

import "../http.dart";
import "http_request.dart";

abstract class PostRequest<T> extends HttpRequest<T> {
  Future<T> post() => Http.post(uri, body, builder, private: private);

  @protected
  T builder(Map<String, dynamic> json);

  @protected
  Map<String, dynamic> get body;
}
