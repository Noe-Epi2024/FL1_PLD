import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/delete_request.dart';

class QuitProject extends DeleteRequest<void> {
  QuitProject({required this.projectId});

  final String projectId;

  @override
  Map<String, dynamic> get body => <String, dynamic>{};

  @override
  void builder(Map<String, dynamic> json) {}

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId/quit');
}
