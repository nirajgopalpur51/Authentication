import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newemail/round_button.dart';
import 'package:newemail/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final postController=TextEditingController();
  bool loading=false;
  final databseRef=FirebaseDatabase.instance.ref("Post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                hintText: "what is in ypour mind",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            Roundbutton(title: "Add",
                loading: loading,
                onTap: (){
              setState(() {
                loading=true;
              });

              databseRef.child(DateTime.now().millisecond.toString()).child("Comments").set({
                "title" :postController.text.toString(),
                "id" :1
              }).then((value){
                Utils().toastMessage("Post added");
                setState(() {
                  loading=false;
                });
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
                setState(() {
                  loading=false;
                });
              });
                })
          ],
        ),
      ),
    );
  }
}
