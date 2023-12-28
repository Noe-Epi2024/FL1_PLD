import 'package:flutter/material.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/http/requests/project/member/post_project_member.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/member/project_member_model.dart';
import 'package:hyper_tools/models/project/project_role.dart';
import 'package:hyper_tools/models/user/user_model.dart';
import 'package:hyper_tools/pages/project/components/members/add/add_project_member_modal_provider.dart';
import 'package:hyper_tools/pages/task/components/members/members_provider.dart';
import 'package:provider/provider.dart';

class AddProjectMemberModalEntry extends StatelessWidget {
  const AddProjectMemberModalEntry({
    required this.projectId,
    required this.user,
    super.key,
  });

  final String projectId;
  final UserModel user;

  Future<void> _onClickAdd(BuildContext context) async {
    final ProjectMembersProvider provider =
        context.read<ProjectMembersProvider>();
    final AddProjectMemberModalProvider modalProvider =
        context.read<AddProjectMemberModalProvider>();

    try {
      await PostProjectMember(
        userRole: ProjectRole.reader,
        projectId: projectId,
        userId: user.id,
      ).send();

      final ProjectMemberModel member = ProjectMemberModel(
        name: user.name,
        role: ProjectRole.reader,
        userId: user.id,
      );

      provider.addMember(member);
      modalProvider.deleteUser(user.id);

      if (context.mounted) Messenger.showSnackBarQuickInfo('Ajouté', context);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Widget _buildAddButton() => Builder(
        builder: (BuildContext context) => TextButton(
          onPressed: () async => _onClickAdd(context),
          child: const Text('Ajouter'),
        ),
      );

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(user.name),
          _buildAddButton(),
        ],
      );
}
