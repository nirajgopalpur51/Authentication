import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newemail/add_firestore_data.dart';
import 'package:newemail/utils.dart';

import 'login_screen.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {

  final auth=FirebaseAuth.instance;
  final editController=TextEditingController();
  final fireStore =FirebaseFirestore.instance.collection("users").snapshots();
 CollectionReference ref=FirebaseFirestore.instance.collection("users");

  void initState(){
    super.initState();
  }
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
          SizedBox(height: 15,),
         StreamBuilder<QuerySnapshot>(
           stream: fireStore,
             builder: ( BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

             if(snapshot.connectionState==ConnectionState.waiting)
               return CircularProgressIndicator();

             if(snapshot.hasError)
               return Text("Some error");
               return Expanded(
                   child: ListView.builder(
                       itemCount: snapshot.data!.docs.length,
                       itemBuilder: (context,index){

                         return ListTile(
                           onTap: (){
                             ref.doc(snapshot.data!.docs[index]["id"].toString()).update({
                               "title" :"Niraj is not good in flutter"
                             }).then((value) {
                               Utils().toastMessage("updated");
                             }).onError((error, stackTrace) {
                               Utils().toastMessage(error.toString());
                             });

                             ref.doc(snapshot.data!.docs[index]["id"].toString()).delete();  //for delete
                           },

                           title: Text(snapshot.data!.docs[index]["title"].toString()),
                           subtitle: Text(snapshot.data!.docs[index]["id"].toString()),
                         );
                       }));
             }
             ),

        ],
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddFireStoreDataScreen()));
        },
      ),
    );
  }
  Future<void> showMyDialog(String title,String id)async{
    editController.text=title;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(
                  hintText: "Edit"
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){;
                Navigator.pop(context);
              }, child: Text("Cancel")),
              TextButton(onPressed: (){;
              Navigator.pop(context);
              }, child: Text("Update"))
            ],
          );
        });
  }
}
