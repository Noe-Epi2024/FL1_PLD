import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/patch_request.dart';
import 'package:hyper_tools/models/user/me_model.dart';

class PatchMe extends PatchRequest<MeModel> {
  PatchMe({this.email, this.name, this.picture});

  final String? email;
  final String? name;
  final String? picture;

  @override
  MeModel builder(Map<String, dynamic> json) => MeModel.fromJson(json);

  @override
  Map<String, dynamic>? get body => <String, dynamic>{
        if (email != null) 'email': email,
        if (name != null) 'name': name,
        if (picture != null) 'picture': picture,
      };

  @override
  bool get private => true;

  @override
  Uri get uri => RouteHelper.buildUri('user/me');
}
