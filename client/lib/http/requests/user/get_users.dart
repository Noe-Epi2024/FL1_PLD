import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/get_request.dart';
import 'package:hyper_tools/models/user/users_model.dart';

class GetUsers extends GetRequest<UsersModel> {
  GetUsers({this.excludeProjectId, this.filter});

  final String? excludeProjectId;
  final String? filter;

  @override
  UsersModel builder(Map<String, dynamic> json) => UsersModel.fromJson(json);

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri(
        'users/all',
        params: <String, String>{
          if (filter != null) 'filter': filter!,
          if (excludeProjectId != null) 'exclude': excludeProjectId!,
        },
      );
}
