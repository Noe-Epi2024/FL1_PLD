import 'package:hyper_tools/components/future_widget/provider_base.dart';
import 'package:hyper_tools/models/project/member/project_member_model.dart';
import 'package:hyper_tools/models/project/member/project_members_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';

class ProjectMembersProvider extends ProviderBase {
  ProjectMembersProvider() : super(isInitiallyLoading: true);

  ProjectMembersModel? _members;

  ProjectMembersModel? get members => _members;

  set members(ProjectMembersModel? value) {
    _members = value;
    notifyListeners();
  }

  String _filter = '';

  String get filter => _filter;

  set filter(String value) {
    _filter = value;
    notifyListeners();
  }

  ProjectMemberModel findMember(String id) => _members!.members
      .firstWhere((ProjectMemberModel member) => member.userId == id);

  void deleteMember(String memberId) {
    if (_members == null) return;

    _members!.members
        .removeWhere((ProjectMemberModel member) => member.userId == memberId);

    notifyListeners();
  }

  void addMember(ProjectMemberModel member) {
    if (_members == null) return;

    _members!.members.add(member);

    notifyListeners();
  }

  void setMemberRole(String memberId, ProjectRole role) {
    findMember(memberId).role = role;
    notifyListeners();
  }
}
