import 'package:flutter/material.dart';
import 'package:hyper_tools/components/shimmer_placeholder.dart';

class ProjectPageLoading extends StatelessWidget {
  const ProjectPageLoading({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const ShimmerPlaceholder(width: 200, height: 20)),
      );
}
