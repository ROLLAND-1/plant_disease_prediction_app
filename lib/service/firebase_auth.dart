import 'package:firebase_auth/firebase_auth.dart';
class AuthService{

  static final AuthService instance = AuthService._();

  late FirebaseAuth _firebaseAuth;

  AuthService._(){
    _firebaseAuth = FirebaseAuth.instance;
  }

  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  User? get getCurrentUser => _firebaseAuth.currentUser; 

  Future signIn(String email, String password)async{
    try{
      var res = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return res;
    }on FirebaseAuthException catch(e){
      return e.message;
    }on Exception{
      return 'Error signing in with email and password';
    }
  }
  Future signUp(String email, String password,String name)async{
    try{
      var res = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseAuth.currentUser?.updateDisplayName(name);
    return res;
    }on FirebaseAuthException catch(e){
      return e.message;
    }on Exception{
      return 'Error signing up with email and password';
    }
  }

  Future forgotPassword(String email)async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
       }on FirebaseAuthException catch(e){
      return e.message;
    }on Exception{
      return 'Error signing up with email and password';
    }
  }

}