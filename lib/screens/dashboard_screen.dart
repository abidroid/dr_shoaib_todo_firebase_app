import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_shoaib_todo_firebase_app/screens/add_task_screen.dart';
import 'package:dr_shoaib_todo_firebase_app/screens/login_screen.dart';
import 'package:dr_shoaib_todo_firebase_app/screens/profile_screen.dart';
import 'package:dr_shoaib_todo_firebase_app/screens/update_task_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  CollectionReference? tasksRef;


  @override
  void initState() {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    tasksRef = FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('tasks');


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return const AddTaskScreen();
        }));
      }, child: const Icon(Icons.add),),
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(onPressed: (){

            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return const ProfileScreen();
            }));
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

      body: StreamBuilder<QuerySnapshot>(
        stream: tasksRef?.snapshots(),
        builder: (context, snapshot){
          if( snapshot.hasData){

            if( snapshot.data == null || snapshot.data!.docs.isEmpty){
              return const Text('No Tasks Found');
            }


            var listOfTasks = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: listOfTasks.length,
                  itemBuilder: (context, index){
                return Card(child: ListTile(
                  title: Text(listOfTasks[index]['title']),
                  subtitle: Text(getHumanReadableDate(listOfTasks[index]['createdOn'])),


                  trailing: SizedBox(width: 100, child: Row(children: [
                    IconButton(onPressed: (){
                      showDialog(context: context, builder: (context){
                        return AlertDialog(title: const Text('Confirmation'),
                        content: const Text('Are you sure to delete ?'),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: const Text('No')),
                            TextButton(onPressed: () async{
                              Navigator.of(context).pop();

                              await tasksRef!.doc(listOfTasks[index]['taskId']).delete();
                              Fluttertoast.showToast(msg: 'Take Deleted');
                            }, child: const Text('Yes')),

                          ],
                        );
                      });
                    }, icon: const Icon(Icons.delete)),
                    IconButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return UpdateTaskScreen(taskSnapshot: listOfTasks[index]);
                      }));

                    }, icon: const Icon(Icons.edit)),

                  ],),),
                ),);
              }),
            );

          }else{
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  String getHumanReadableDate( int timestamp ){

    DateFormat dateFormat = DateFormat('dd-MMM-yy HH:mm');
    
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(timestamp));

  }
}
