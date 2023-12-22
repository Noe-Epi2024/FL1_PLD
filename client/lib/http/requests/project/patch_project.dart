import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/patch_request.dart';

class PatchProject extends PatchRequest<void> {
  PatchProject({required this.projectId, this.name});

  final String projectId;
  final String? name;

  @override
  Map<String, dynamic> get body =>
      <String, dynamic>{if (name != null) 'name': name};

  @override
  void builder(Map<String, dynamic> json) {}

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId');
}
