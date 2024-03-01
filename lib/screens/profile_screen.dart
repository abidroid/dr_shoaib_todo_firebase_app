import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DocumentSnapshot? userSnapshot;

  File? chosenImage;
  bool showLocalImage = false;

  getUserDetails() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    setState(() {});
  }

  selectImageFrom(ImageSource imageSource) async {
    XFile? xFile = await ImagePicker().pickImage(source: imageSource);

    if (xFile == null) return;

    chosenImage = File(xFile.path);

    setState(() {
      showLocalImage = true;
    });

    // upload image to storage

    FirebaseStorage storage = FirebaseStorage.instance;

    var fileName = userSnapshot!['email'] + '.png';

    UploadTask uploadTask = storage
        .ref()
    //.child('profile_images')
        .child(fileName)
        .putFile(chosenImage!, SettableMetadata(contentType: 'image/png'));

    TaskSnapshot snapshot = await uploadTask;

    String profileImageUrl = await snapshot.ref.getDownloadURL();
    print(profileImageUrl);


    // save its url in users collection

    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'photo': profileImageUrl});

    Fluttertoast.showToast(msg: 'Profile image uploaded');


  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: userSnapshot != null
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: showLocalImage
                          ? FileImage(chosenImage!) as ImageProvider
                          : NetworkImage(userSnapshot!['photo'] ??
                              'https://www.hksyu.edu/assets/staffs/default/default_staff.png'),
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.image),
                                      title: Text('Gallery'),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        selectImageFrom(ImageSource.gallery);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text('Camera'),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        selectImageFrom(ImageSource.camera);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.camera_alt)),
                  ],
                ),
                const Gap(16),
                Text(userSnapshot!['name']),
                Text(userSnapshot!['gender']),
                Text(userSnapshot!['email']),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
