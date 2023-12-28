import 'dart:async';

import 'package:hyper_tools/http/http.dart';
import 'package:hyper_tools/http/requests/http_request.dart';

abstract class GetRequest<T> extends HttpRequest<T> {
  @override
  Future<T> send() => Http.get(uri, builder, private: private);
}
