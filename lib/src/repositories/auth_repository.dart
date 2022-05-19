import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> logInWithCredentials(
      {required String email, required String password}) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUpWithCredentials(
      {required String email, required String password}) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<bool> isSignedIn() async {
    User? currentUser = auth.currentUser;
    currentUser ??= await FirebaseAuth.instance.authStateChanges().first;

    return currentUser != null;
  }
}
