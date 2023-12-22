enum ProjectRole {
  owner,
  writer,
  reader;

  factory ProjectRole.parse(String value) => ProjectRole.values
      .firstWhere((ProjectRole element) => element.name == value);
}
