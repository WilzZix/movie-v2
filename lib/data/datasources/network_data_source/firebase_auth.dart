import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie/domain/repositories/i_firebase_auth.dart';

class FirebaseAuthImpl extends IFirebaseAuth {
  @override
  FutureOr<UserCredential> userLoginWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  @override
  FutureOr<UserCredential> userRegisterWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  FutureOr<void> signOutRequest() async {
    await FirebaseAuth.instance.signOut();
  }
}
