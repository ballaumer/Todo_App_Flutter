import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/helper/api_response.dart';

class GoogleAuthServices {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
    return null;
  }


  // services for log-out
  Future<ApiResponse> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      return ApiResponse(data: true);
    } catch (e) {
      print('Error signing out: $e');
      return ApiResponse(data: false);

    }
  }
}