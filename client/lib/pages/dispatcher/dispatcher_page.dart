import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/consts/consts.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/helpers/local_storage_helper.dart';
import 'package:hyper_tools/http/http.dart';
import 'package:hyper_tools/pages/home/home_page.dart';
import 'package:hyper_tools/pages/landing/landing_page.dart';

class DispatcherPage extends HookWidget {
  const DispatcherPage({super.key});

  Future<void> _dispatch() async {
    final String? accessToken =
        await LocalStorageHelper.read(Consts.accessTokenKey);

    if (accessToken != null) {
      Http.accessToken = accessToken;
      await Navigation.push(const HomePage(), replaceAll: true);
    } else {
      await Navigation.push(const LandingPage(), replaceAll: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        unawaited(_dispatch());
        return null;
      },
      <Object?>[],
    );

    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
