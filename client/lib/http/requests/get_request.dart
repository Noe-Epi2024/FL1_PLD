import "dart:async";

import "package:flutter/material.dart";

import "../http.dart";
import "http_request.dart";

abstract class GetRequest<T> extends HttpRequest<T> {
  Future<T> get() => Http.get(uri, builder, private: private);

  @protected
  T builder(Map<String, dynamic> json);
}
