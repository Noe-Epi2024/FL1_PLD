import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension EmptyPadding on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

extension EdgeInsetsExtension on num {
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get all => EdgeInsets.all(toDouble());
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
