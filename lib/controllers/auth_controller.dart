import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/utils/navigator.dart';
import 'package:todo/views/log_in.dart';
import '../helper/api_response.dart';
import '../services/auth_services.dart';


class GoogleAuthController extends ChangeNotifier{
  final GoogleAuthServices _googleSignInService = GoogleAuthServices();



  Future<ApiResponse> signInWithGoogle(context) async {
    final User? userCredential = await _googleSignInService.signInWithGoogle();
    if (userCredential != null) {
      return ApiResponse(data:  true);
    } else {
      return ApiResponse(data: false);

    }
  }

  signOut(context)async{
    await _googleSignInService.signOut().then((value) {
      if(value.data == true){
        Navi.navigatePushRemoveTo(context, LoginScreen());
      }
    });
  }
}
