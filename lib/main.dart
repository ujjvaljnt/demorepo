import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learn_firebase_auth/home_page.dart';
import 'package:learn_firebase_auth/login_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginView(),
      routes: {
        HomeView.route: (context) => HomeView(),
        LoginView.route: (context) => LoginView(),
      },
    );
  }
}
