import 'package:ecotone_app/routes/login_and_signup/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


//Email Sign up
class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);
  Future<void> signupWithEmail({
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
  //State Persistence
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  //Email Verification
  Future<void> sendEmailVerification(BuildContext context) async {
    try{
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, "Email Verification Sent!");
    }on FirebaseAuthException catch (e){
      showSnackBar(context, e.message!);
    }
  }


  //Email Login
 Future<void> loginWithEmail({
   required String email,
   required String password,
   required BuildContext context,
}) async {
    try{
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if (!_auth.currentUser!.emailVerified){
        await sendEmailVerification(context);
      }
    }
    on FirebaseAuthException catch (e){
      showSnackBar(context, e.message!);
    }
 }

 //Google Sign in
  Future<void> signInWithGoogle(BuildContext context) async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      if (googleAuth?.accessToken !=null && googleAuth?.idToken != null){
        //Create New Credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

      }
    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message!);
    }
  }
  //Facebook Sign in
  Future<void> signInWithFacebook (BuildContext context) async{
    try{
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _auth.signInWithCredential(facebookAuthCredential);

    } on FirebaseAuthException catch (e){
      showSnackBar(context, e.message!);
    }
  }

  //Apple Sign in
  Future<void> signInWithApple (BuildContext context) async{
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
    ]
    );
  }

  //Sign Out
  Future<void> signOut(BuildContext context) async {
    try{
      await _auth.signOut();
    }
    on FirebaseAuthException catch(e){
      showSnackBar(context, e.message!);
    }
  }
}

