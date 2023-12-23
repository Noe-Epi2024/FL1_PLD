import 'package:hyper_tools/components/future_widget/provider_base.dart';
import 'package:hyper_tools/models/project/member/project_members_model.dart';

class ProjectMembersProvider extends ProviderBase {
  ProjectMembersModel? _members;

  ProjectMembersModel? get members => _members;

  set members(ProjectMembersModel? value) {
    _members = value;
    notifyListeners();
  }
}
