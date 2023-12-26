import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ProjectRole {
  owner(icon: FontAwesomeIcons.crown),
  admin(icon: FontAwesomeIcons.screwdriverWrench),
  writer(icon: FontAwesomeIcons.pen),
  reader(icon: FontAwesomeIcons.solidEye);

  const ProjectRole({required this.icon});

  factory ProjectRole.parse(String value) =>
      ProjectRole.values.firstWhere((ProjectRole role) => role.name == value);

  final IconData icon;
}
