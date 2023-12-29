import 'package:flutter/material.dart';

extension BranchBool on bool {
  Widget? branch({
    Widget? trueChild,
    Widget? falseChild,
  }) =>
      this ? trueChild : falseChild;
}
