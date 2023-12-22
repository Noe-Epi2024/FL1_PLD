import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hyper_tools/http/http.dart';
import 'package:hyper_tools/http/requests/http_request.dart';

abstract class DeleteRequest<T> extends HttpRequest<T> {
  Future<T> delete() => Http.delete(uri, body, builder, private: private);

  @protected
  T builder(Map<String, dynamic> json);

  @protected
  Map<String, dynamic> get body;
}
