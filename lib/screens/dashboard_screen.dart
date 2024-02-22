import 'package:dr_shoaib_todo_firebase_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.person)),
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: const Text('Confirmation'),
                content: const Text('Are you sure to Logout ?'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text('No')),
                  TextButton(onPressed: () async {
                    Navigator.pop(context);

                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                      return const LoginScreen();
                    }));

                  }, child: const Text('yes')),

                ],
              );
            });
          }, icon: const Icon(Icons.logout)),

        ],
      ),

      body: const Placeholder(),
    );
  }
}
