class RouteHelper {
  static const String _kServerEndpoint = 'http://13.39.148.222:8080';

  static String _buildQuery(Map<String, String> params) {
    String query = '';
    final List<MapEntry<String, String>> entries = params.entries.toList();

    for (int i = 0; i < entries.length; i++) {
      if (i > 0) query += '&';
      query += '${entries[i].key}=${entries[i].value}';
    }

    return query;
  }

  static Uri buildUri(String route, {Map<String, String>? params}) {
    String uri = '$_kServerEndpoint/$route';

    if (params != null) uri += '?${_buildQuery(params)}';

    return Uri.parse(uri);
  }
}
