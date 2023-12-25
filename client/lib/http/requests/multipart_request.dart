import 'package:hyper_tools/http/http.dart';
import 'package:hyper_tools/http/requests/http_request.dart';

abstract class MultipartRequest<T> extends HttpRequest<T> {
  MultipartRequest({required this.filePath});

  final String filePath;

  Future<T> send() =>
      Http.multipart('POST', uri, filePath, builder, private: private);
}
