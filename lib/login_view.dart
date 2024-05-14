// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_firebase_auth/home_page.dart';

class LoginView extends StatefulWidget {
  static const route = '/login';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String phno = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Auth"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: "Phone Number:"),
              onChanged: (value) => setState(() => phno = value),
            ),
            ElevatedButton(
              onPressed: manageSignIn,
              child: const Text("Send Otp"),
            ),
          ],
        ),
      ),
    );
  }

  void manageSignIn() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phno,
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = '';
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Enter OTP"),
            content: TextField(
              onChanged: (value) => smsCode = value,
              decoration: const InputDecoration(hintText: 'OTP'),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: smsCode.trim());
                    UserCredential userCredential =
                        await _auth.signInWithCredential(credential);
                    User user = userCredential.user!;
                    if (user.uid.isNotEmpty) {
                      Navigator.pushNamed(context, HomeView.route);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Invalid Code"),
                          content: const Text("Please Enter the correct code."),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Done"))
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text("Submit"))
            ],
          ),
        );

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        await _auth.signInWithCredential(credential);
      },
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (verificationId) {},
      verificationCompleted: (phoneAuthCredential) async {
        _auth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) {
        print(error);
      },
    );
  }
}
