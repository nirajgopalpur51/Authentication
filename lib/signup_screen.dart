import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newemail/login_screen.dart';
import 'package:newemail/post_screen.dart';
import 'package:newemail/round_button.dart';
import 'package:newemail/utils.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({Key? key}) : super(key: key);

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {





  bool loading=false;
  final _formKey =GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  FirebaseAuth _auth= FirebaseAuth.instance;

  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void login(){
    if(_formKey.currentState!.validate()){
      setState(() {
        loading=true;
      });

      _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()).then((value){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PostScreen()));
        setState(() {
          loading=false;
        });
      }).onError((error, stackTrace) {
        setState(() {
          loading=false;
        });
        Utils().toastMessage(error.toString());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Login")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              key :_formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.alternate_email)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter password";
                        }
                        return null;
                      },
                    ),

                  ],
                ),
              )),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Roundbutton(
              title: "Register",
              loading: loading,
              onTap: (){
               login();
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Center(child: Text("Already have an account",style: TextStyle(fontSize: 15),)),
              TextButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>loginScreen()));
              }, child: Text("Login"))
            ],
          )
        ],
      ),
    );
  }
}
