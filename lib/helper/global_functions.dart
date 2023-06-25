import 'package:firebase_auth/firebase_auth.dart';

fetchCurrentUserUid() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String uid = user.uid;
    return uid;
  } else {
    return null;
  }
}