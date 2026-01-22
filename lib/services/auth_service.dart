import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Using Email and Password SignUP
  Future<User> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user!;
  }

  //Using Email and Password Login
  Future<User> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user!;
  }

  //USING GOOGLE LOGIN / SIGNUP
  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign-in cancelled');
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final result = await _auth.signInWithCredential(credential);
    return result.user!;
  }

  User? get currentUser => _auth.currentUser;
  //DELETE FOR LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  //DELETE FOR AUTHENTICATED ACCOUNT
  Future<void> deleteAuthAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.delete();
    }
  }

  //CHANGE PASSWORD THROUGH EMAIL
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
