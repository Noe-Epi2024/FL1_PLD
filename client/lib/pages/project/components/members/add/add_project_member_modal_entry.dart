import 'package:flutter/cupertino.dart';
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
    required this.userId,
    super.key,
  });

  final String projectId;
  final String userId;

  Future<void> _onClickAdd(BuildContext context) async {
    try {
      await PostProjectMember(
        userRole: ProjectRole.reader,
        projectId: projectId,
        userId: userId,
      ).post();

      final UserModel user =
          context.read<AddProjectMemberModalProvider>().findUser(userId);

      final ProjectMemberModel member = ProjectMemberModel(
        name: user.name,
        role: ProjectRole.reader,
        userId: userId,
      );

      context.read<ProjectMembersProvider>().addMember(member);
      context.read<AddProjectMemberModalProvider>().deleteUser(userId);

      Messenger.showSnackBarQuickInfo('Ajouté', context);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user =
        context.read<AddProjectMemberModalProvider>().findUser(userId);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(user.name),
        TextButton(
          onPressed: () async => _onClickAdd(context),
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}
