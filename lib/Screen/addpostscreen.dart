import 'dart:io';

import 'package:blog_app/widget/Utils.dart';
import 'package:blog_app/widget/btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool showSpiner = false;
  // final postRef = FirebaseDatabase.instance.ref().child('Posts');

  final postRef = FirebaseDatabase.instance.ref().child('Post');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

      FirebaseAuth _auth = FirebaseAuth.instance;

  File? _image;
  final picker = ImagePicker();
  TextEditingController titleController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(msg: 'No Image Selected');
      }
    });
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(msg: 'No Image Selected');
      }
    });
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImageCamera();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camera"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.browse_gallery),
                      title: Text("Gallery"),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpiner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Upload Blog"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    dialog(context);
                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * 1,
                      child: _image != null
                          ? ClipRRect(
                              child: Image.file(
                                _image!.absolute,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                          labelText: 'Enter Title',
                          hintText: 'Enter post title',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: searchController,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                          labelText: 'Enter Desc',
                          hintText: 'Enter post Desc',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundButton(
                        onPress: () async {
                          setState(() {
                            showSpiner = true;
                          });

                          try {
                            setState(() {
                              showSpiner = true;
                            });
                            int date = DateTime.now().microsecondsSinceEpoch;

                            firebase_storage.Reference ref = firebase_storage
                                .FirebaseStorage.instance
                                .ref('/BLOG_APP$date');

                            UploadTask uploadTask =
                                ref.putFile(_image!.absolute);

                            await Future.value(uploadTask);
                         
                            var newUrl = await ref.getDownloadURL();
                            // newUrl.child('Post List').child(date.toString()).
                            
                            final User? user = _auth.currentUser;

                            postRef
                                .child('Post List')
                                .child(date.toString())
                                .set({
                                  'pTime': date.toString(),
                                  'pImage': newUrl.toString(),
                                  'pTitle': titleController.text.toString(),
                                  'pDescr': searchController.text.toString(),
                                  'pEmail': user!.email.toString(),
                                  'pId': user.uid.toString(),
                                }).then((value) {
                              Utils.showmessage('Post Publish');
                              setState(() {
                                showSpiner = false;
                              });
                            }).onError((error, stackTrace) {
                              Utils.showmessage(error.toString());
                              setState(() {
                                showSpiner = false;
                              });
                            });
                          } catch (e) {
                            setState(() {
                              showSpiner = false;
                            });

                            Utils.showmessage(e.toString());
                          }
                        },
                        title: 'Upload')
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
