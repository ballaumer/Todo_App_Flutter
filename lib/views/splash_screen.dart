import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/views/home.dart';
import 'package:todo/views/log_in.dart';

import '../helper/global_functions.dart';
import '../utils/navigator.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>with SingleTickerProviderStateMixin {



  late AnimationController animationController;
  late Animation<double> animation;
  String? uid;



  @override
  void initState() {
    uid = fetchCurrentUserUid();
    var d = const Duration(seconds: 3);
    Future.delayed(d, () async{
      if( uid != null){
        Navi.navigatePushRemoveTo(context, const HomeScreen());
      }else{
        Navi.navigatePushRemoveTo(context,  LoginScreen());
      }
    });

    super.initState();

    animationController =  AnimationController(
        vsync: this, duration:  const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

    animation.addListener(() => setState(() {}));
    animationController.forward();

  }

  @override
  Widget build(BuildContext context) {
    return      Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Center(
            child:  Image.asset("assets/images/logo.png",width: animation.value * 250,
              height: animation.value * 250,
            ),
          ),
        ],
      ),
    );
  }
  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }
}
