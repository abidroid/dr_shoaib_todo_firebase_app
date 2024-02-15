import 'package:dr_shoaib_todo_firebase_app/screens/forgot_password_screen.dart';
import 'package:dr_shoaib_todo_firebase_app/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailC, passC;

  @override
  void initState() {
    emailC = TextEditingController();
    passC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
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
            ElevatedButton(
              onPressed: () {},
              child: const Text('Login'),
            ),


            const Gap(16),
            
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return const SignUpScreen();
              }));
            }, child: const Text('Not Registered Yet? Sign up')),


            const Gap(16),

            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return const ForgotPasswordScreen();
              }));

            }, child: const Text('Forgot Password')),
          ],
        ),
      ),
    );
  }
}
