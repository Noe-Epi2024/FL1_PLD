import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Demo', debugShowCheckedModeBanner: false, home: App());
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(ctx) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(color: Colors.red, width: 100),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(color: Colors.yellow, height: 100, width: 100),
              Container(color: Colors.green, height: 100, width: 100)
            ]),
            Container(color: Colors.blue, width: 100)
          ]),
        ));
  }
}
