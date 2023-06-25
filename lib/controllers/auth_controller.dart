import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
}
