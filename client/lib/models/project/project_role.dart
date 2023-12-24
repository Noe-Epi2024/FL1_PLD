import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

enum ProjectRole {
  owner(icon: Boxicons.bx_crown),
  writer(icon: Boxicons.bx_edit),
  reader(icon: Icons.remove_red_eye_outlined);

  const ProjectRole({required this.icon});

  factory ProjectRole.parse(String value) => ProjectRole.values
      .firstWhere((ProjectRole element) => element.name == value);

  final IconData icon;
}
