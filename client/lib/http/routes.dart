class Routes {
  static const String _kServerEndpoint = 'http://13.39.148.222:8080';

  static Uri _uri(String route) => Uri.parse('$_kServerEndpoint/$route');

  static Uri get login => _uri('login');

  static Uri get register => _uri('register');

  static Uri get projectAll => _uri('project/project/all');
}
