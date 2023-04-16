import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newemail/post_screen.dart';
import 'package:newemail/round_button.dart';
import 'package:newemail/utils.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationonId;
  const VerifyCodeScreen({Key? key,
    required this.verificationonId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading=false;
  final auth=FirebaseAuth.instance;
  final verificationCodeController=TextEditingController();
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
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "6 digit code"
              ),
            ),
            SizedBox(height: 30,),
            Roundbutton(
                title: "Verify",
                loading: loading,
                onTap: () async{
                  setState(() {
                    loading=true;
                  });
                  final credential=PhoneAuthProvider.credential(
                      verificationId: widget.verificationonId,
                      smsCode: verificationCodeController.text.toString());

                  try{
                    await auth.signInWithCredential(credential);
                    
                    Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => PostScreen()));
                  }catch(e){
                    setState(() {
                      loading=false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
