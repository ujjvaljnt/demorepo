import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static const route = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}
