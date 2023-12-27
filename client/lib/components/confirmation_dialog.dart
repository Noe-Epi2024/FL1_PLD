import 'package:flutter/material.dart';
import 'package:hyper_tools/components/evenly_sized_children.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TitleText(title),
              16.height,
              Text(
                subtitle,
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
              32.height,
              EvenlySizedChildren(
                children: <Widget>[
                  TextButton(
                    child: const Text('Non'),
                    onPressed: () => Navigation.pop(false),
                  ),
                  ElevatedButton(
                    child: const Text('Oui'),
                    onPressed: () => Navigation.pop(true),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

Future<bool> confirmationDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmationDialog(title: title, subtitle: subtitle),
    ) ??
    false;
