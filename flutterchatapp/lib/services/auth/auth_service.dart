import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instance of Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get Current User
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  // Sign IN
  Future<UserCredential> signInWEmailPassword(String email, password) async {
    try {

      // Sign in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Save user if don't exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid':userCredential.user!.uid,
          'email': email
        }
      );


      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign UP
  Future<UserCredential> signUpWEmailPassword(String email, password) async {
    try {
      // Create USer
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);


      // Save user seperate
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email
        }
      );

          return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // Errors
}
