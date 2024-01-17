import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce_app_knowledge/models/user_data.dart';
import 'package:flutter_ecommerce_app_knowledge/services/firestore_services.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/api_path.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> login(String email, String password);
  Future<bool> register(String email, String password, String username);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<bool> loginWithGoogle();
  Future<User?> getUser();
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  final firestore = FirestoreService.instance;

  @override
  Future<bool> login(String email, String password) async {
    UserCredential userData = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (userData.user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> register(String email, String password, String username) async {
    UserCredential userData = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userData.user != null) {
      final currentUserData = UserData(
      id: userData.user!.uid,
      email: email,
      username: username, password: password,
    );
      await firestore.setData(
        path: ApiPath.user(currentUserData.id),
        data: currentUserData.toMap(),
      );
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isLoggedIn() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> loginWithGoogle() async {
    final _googleSignIn = GoogleSignIn();
    // try {
    GoogleSignInAccount? userData = await _googleSignIn.signIn();
    if (userData != null) {
      GoogleSignInAuthentication googleAuth = await userData.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.user != null) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
    // } catch (error) {
    //   print(error);
    // }
  }

  @override
  Future<User?> getUser() {
    return Future.value(_firebaseAuth.currentUser);
  }
}
