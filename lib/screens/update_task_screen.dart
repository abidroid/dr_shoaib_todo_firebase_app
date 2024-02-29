import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class UpdateTaskScreen extends StatefulWidget {
  final DocumentSnapshot taskSnapshot;

  const UpdateTaskScreen({super.key, required this.taskSnapshot});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {

  TextEditingController taskC = TextEditingController();


  @override
  void initState() {
    taskC.text = widget.taskSnapshot['title'];
    super.initState();
  }

  @override
  void dispose() {
    taskC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Screen'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskC,
              decoration: const InputDecoration(
                  hintText: 'Task Name', border: OutlineInputBorder()),
            ),
            const Gap(16),
            ElevatedButton(
                onPressed: () async {
                  String taskTitle = taskC.text.trim();

                  String uid = FirebaseAuth.instance.currentUser!.uid;
                  var taskRef = FirebaseFirestore.instance.collection('tasks').doc(uid)
                  .collection('tasks').doc(widget.taskSnapshot['taskId']);

                  await taskRef.update({ 'title': taskTitle});
                  Fluttertoast.showToast(msg: 'Updated');

                  if( mounted){
                    Navigator.of(context).pop();

                  }

                },
                child: const Text('Update'))
          ],
        ),
      ),
    );
  }
}
