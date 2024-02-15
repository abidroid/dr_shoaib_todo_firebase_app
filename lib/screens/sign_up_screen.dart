import 'package:dr_shoaib_todo_firebase_app/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameC, mobileC, emailC, passC, confirmC;
  String selectedGender = 'Male';

  @override
  void initState() {
    nameC = TextEditingController();
    mobileC = TextEditingController();
    emailC = TextEditingController();
    passC = TextEditingController();
    confirmC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    mobileC.dispose();
    emailC.dispose();
    passC.dispose();
    confirmC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameC,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            TextField(
              controller: mobileC,
              decoration: const InputDecoration(
                hintText: 'Mobile',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            TextField(
              controller: emailC,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            TextField(
              controller: passC,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            TextField(
              controller: confirmC,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Register'),
            ),
            const Gap(16),

            CupertinoSegmentedControl(
                groupValue: selectedGender,
                children: const {
              'Male': Text('Male'),
              'Female': Text('Female'),
              'Other': Text('Other')
            }, onValueChanged: (newValue){
                setState(() {
                  selectedGender = newValue;
                });
            }),

            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Already Registered? Login')),
          ],
        ),
      ),
    );
  }
}
