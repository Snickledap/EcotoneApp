import 'package:ecotone_app/routes/login/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async{
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    }
    catch (e) { print(e.toString());
    }

    notifyListeners();
  }
  Future logout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();

  }

}

class EmailFirebaseAuth {
  final FirebaseAuth _auth;
  EmailFirebaseAuth(this._auth);
  Future<void> SignUpWithEmail({
  required String email,
  required String password,
  required BuildContext context,
}) async{
    try{
      await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    }
    on FirebaseAuthException catch (e){
      showSnackBar(context,e.message!);
    }
  }
}