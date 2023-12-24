import 'package:flutter/material.dart';
import 'package:hyper_tools/components/shimmer_placeholder.dart';

class TaskPageLoader extends StatelessWidget {
  const TaskPageLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const ShimmerPlaceholder(
            width: 200,
            height: 20,
          ),
        ),
        body: const SafeArea(child: Center(child: CircularProgressIndicator())),
      );
}
