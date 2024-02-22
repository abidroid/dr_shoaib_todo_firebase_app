import 'dart:async';

import 'package:dr_shoaib_todo_firebase_app/screens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  Timer? timer;

  @override
  void initState() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  void checkEmailVerified() {

    FirebaseAuth.instance.currentUser!.reload();

    if( FirebaseAuth.instance.currentUser!.emailVerified){

      timer?.cancel();

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return const DashboardScreen();
      }));
    }else{

    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Email Verification'),
        ),
        body: ListView(
          children: [
            const Text(
              'An Email has been sent to your account\nPlease verify your email',
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            const CircularProgressIndicator(),
            const Gap(20),
            ElevatedButton(onPressed: () {

              FirebaseAuth.instance.currentUser!.sendEmailVerification();

            }, child: const Text('Resend Email'))
          ],
        ));
  }
}
