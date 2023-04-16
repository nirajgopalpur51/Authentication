import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newemail/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen=SplashServices();
  void initState(){
    super.initState();
    splashScreen.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:Center(child: Text("firebase authentication",style: TextStyle(fontSize: 30),))
    );
  }
}
