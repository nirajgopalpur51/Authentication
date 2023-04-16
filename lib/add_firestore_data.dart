import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newemail/round_button.dart';
import 'package:newemail/utils.dart';

class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {

  final postController=TextEditingController();
  bool loading=false;
  final fireStore =FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add FireStore Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),

            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                hintText: "What is in your mind",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),

            Roundbutton(
                title: "Add",
                loading : loading,
                onTap: (){
                  setState((){
                    loading=true;
                  });
                  String id=DateTime.now().millisecondsSinceEpoch.toString();
                  fireStore.doc(id).set({
                    "title" :postController.text.toString(),
                    "id" :id
                  }).then((value) {
                    setState(() {
                      loading=false;
                    });
                    Utils().toastMessage("Post Added");
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading=false;
                    });
                    Utils().toastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
