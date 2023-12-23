import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/patch_request.dart';

class PatchTask extends PatchRequest<void> {
  PatchTask({
    required this.projectId,
    required this.taskId,
    this.name,
    this.description,
    this.ownerId,
    this.startDate,
    this.endDate,
  });

  final String projectId;
  final String taskId;
  final String? name;
  final String? description;
  final String? ownerId;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Map<String, dynamic>? get body => <String, dynamic>{
        if (ownerId != null) 'ownerId': ownerId,
        if (description != null) 'description': description,
        if (name != null) 'name': name,
        if (startDate != null) 'startDate': startDate!.toIso8601String(),
        if (endDate != null) 'endDate': endDate!.toIso8601String(),
      };

  @override
  void builder(Map<String, dynamic> json) {}

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId/task/$taskId');
}
