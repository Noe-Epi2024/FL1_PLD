import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/post_request.dart';
import 'package:hyper_tools/models/success_model.dart';

class PostProject extends PostRequest<String> {
  PostProject({required this.name});

  final String name;

  @override
  Map<String, dynamic> get body => <String, String>{'name': name};

  @override
  String builder(Map<String, dynamic> json) =>
      SuccessModel.fromJson(json).data['id'];

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('project');
}
