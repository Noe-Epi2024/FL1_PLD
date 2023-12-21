import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

extension EdgeInsetsExtension on num {
  EdgeInsetsGeometry get h => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsetsGeometry get v => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsetsGeometry get a => EdgeInsets.all(toDouble());
}

extension WidgetProvider on Widget {
  ChangeNotifierProvider<K> provider<K extends ChangeNotifier>(
    K Function(BuildContext context) create,
  ) =>
      ChangeNotifierProvider<K>(
        create: create,
        child: this,
      );
}
