import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/get_request.dart';
import 'package:hyper_tools/models/user/me_model.dart';

class GetMe extends GetRequest<MeModel> {
  @override
  MeModel builder(Map<String, dynamic> json) => MeModel.fromJson(json);

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('user/me');
}
