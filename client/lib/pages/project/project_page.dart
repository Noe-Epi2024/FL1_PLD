// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
// import 'package:hyper_tools/global/messenger.dart';
// import 'package:hyper_tools/models/error_model.dart';
// import 'package:hyper_tools/pages/project/project_provider.dart';
// import 'package:provider/provider.dart';

// class ProjectPage extends StatelessWidget {
//   const ProjectPage(this.id, {super.key});

//   final String id;

//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider<ProjectProvider>(
//         create: (_) => ProjectProvider(),
//         child: _ProjectPageBuilder(id),
//       );
// }

// class _ProjectPageBuilder extends HookWidget {
//   const _ProjectPageBuilder(this.id);

//   final String id;

//   Future<void> _getProject(BuildContext context){
//     try{

//     }
//     on ErrorModel catch (e)
//     {
//       Messenger.showSnackBarError(e.errorMessage);
//     }
//   }

//   @override
//   Widget build(BuildContext context) => ProviderResolver.future(builder: , future: future)
// }
