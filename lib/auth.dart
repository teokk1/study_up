import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
	Auth({
		@required this.googleSignIn,
		@required this.firebaseAuth,
	});

	final GoogleSignIn googleSignIn;
	final FirebaseAuth firebaseAuth;

	Future<FirebaseUser> signInWithGoogle() async
	{
		final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
		final GoogleSignInAuthentication googleAuth =	await googleAccount.authentication;
    
		return firebaseAuth.signInWithGoogle(accessToken: googleAuth.accessToken,idToken: googleAuth.idToken,);
	}
}