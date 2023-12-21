import 'package:flutter/material.dart';

class MultiCard extends StatelessWidget {
  const MultiCard({required this.children, super.key, this.margin});

  final List<Widget> children;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) => Card(
        margin: margin,
        child: Column(
          children: children
              .asMap()
              .entries
              .map(
                (MapEntry<int, Widget> e) => e.key < children.length - 1
                    ? DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: .5,
                              color: Theme.of(context).dividerTheme.color!,
                            ),
                          ),
                        ),
                        child: e.value,
                      )
                    : e.value,
              )
              .toList(),
        ),
      );
}
