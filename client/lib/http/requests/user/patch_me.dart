import 'package:hyper_tools/helpers/route_helper.dart';
import 'package:hyper_tools/http/requests/patch_request.dart';

class PatchMe extends PatchRequest<void> {
  PatchMe({this.email, this.name, this.picture});

  final String? email;
  final String? name;
  final String? picture;

  @override
  void builder(Map<String, dynamic> json) {}

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
