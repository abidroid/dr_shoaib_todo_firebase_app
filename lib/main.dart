import 'package:dr_shoaib_todo_firebase_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: 'AIzaSyCpaYZezk_JBSAvODn8Fklkzk7qyOwfsqE',
        appId: '1:287194195105:android:3da5f0e1e2b1f9d5cebce0',
        messagingSenderId: '287194195105',
        projectId: 'tododrshoaib',
        storageBucket: 'tododrshoaib.appspot.com'
      )
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
