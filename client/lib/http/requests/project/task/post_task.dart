import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/post_request.dart';

class PostTask extends PostRequest<String> {
  PostTask({
    required this.projectId,
    this.name,
    this.description,
    this.ownerId,
    this.startDate,
    this.endDate,
  });

  final String projectId;
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
  String builder(Map<String, dynamic> json) => json['id'];

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project/$projectId/task');
}
