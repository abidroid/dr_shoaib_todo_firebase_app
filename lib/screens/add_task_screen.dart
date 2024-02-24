import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController taskC = TextEditingController();

  @override
  void dispose() {
    taskC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
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

                  var taskRef = FirebaseFirestore.instance
                      .collection('tasks')
                      .doc(uid)
                      .collection('tasks')
                      .doc();


                  try{
                    await taskRef.set({
                      'title': taskTitle,
                      'createdOn': DateTime.now().millisecondsSinceEpoch,
                      'taskId': taskRef.id,
                    });

                    Fluttertoast.showToast(msg: 'Task Saved');

                  }catch (e){
                    Fluttertoast.showToast(msg: e.toString());
                  }
                },
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
