import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newemail/round_button.dart';
import 'package:newemail/utils.dart';
import 'package:newemail/verify_code.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {


  bool loading=false;
  final auth=FirebaseAuth.instance;
  final phonenumberController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80,),
            TextFormField(
              controller: phonenumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "+91 1234567890"
              ),
            ),
            SizedBox(height: 30,),
            Roundbutton(
                title: "login",
                loading: loading,
                onTap: (){

                  setState(() {
                    loading=true;
                  });
                  auth.verifyPhoneNumber(
                    phoneNumber: phonenumberController.text,
                      verificationCompleted: (_){
                        setState(() {
                          loading=false;
                        });
                      },
                      verificationFailed: (e){
                        setState(() {
                          loading=false;
                        });
                      Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verification,int? token){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              VerifyCodeScreen(verificationonId: verification,)));
                      setState(() {
                        loading=false;
                      });
                      },
                      codeAutoRetrievalTimeout: (e){

                        Utils().toastMessage(e.toString());
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
