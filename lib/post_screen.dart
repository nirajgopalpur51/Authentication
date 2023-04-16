import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:newemail/add_posts.dart';
import 'package:newemail/login_screen.dart';
import 'package:newemail/utils.dart';

class PostScreen extends StatelessWidget {
  void tasks(){

  }

   PostScreen({Key? key}) : super(key: key);
  final auth=FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.ref("Post");
  // final searchFilter=te
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>loginScreen()));
            }).onError((error, stackTrace) {
              Utils().toastMessage.toString();
            });
          }, icon: Icon(Icons.logout)),
          SizedBox(width: 10,),

        ],
      ),
      body: Column(
        children: [

          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('Loading'),
                itemBuilder: (context, snapshot, animation, index){
                  return   ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                  );
                }
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },child: Icon(Icons.add),
      ),

    );
  }
}
