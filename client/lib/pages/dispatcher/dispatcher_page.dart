import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hyper_tools/consts/consts.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/http/http.dart';
import 'package:hyper_tools/local_storage/local_storage.dart';
import 'package:hyper_tools/pages/home/home_page.dart';
import 'package:hyper_tools/pages/landing/landing_page.dart';

class DispatcherPage extends StatefulWidget {
  const DispatcherPage({super.key});

  @override
  State<DispatcherPage> createState() => _DispatcherPageState();
}

class _DispatcherPageState extends State<DispatcherPage> {
  Future<void> _dispatch() async {
    final String? accessToken = await LocalStorage.read(Consts.accessTokenKey);

    if (accessToken != null) {
      Http.accessToken = accessToken;
      await Navigation.push(const HomePage(), replaceAll: true);
    } else {
      await Navigation.push(const LandingPage(), replaceAll: true);
    }
  }

  @override
  void initState() {
    unawaited(_dispatch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
